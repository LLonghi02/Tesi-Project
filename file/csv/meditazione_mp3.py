from googleapiclient.discovery import build
import csv
import re
import yt_dlp
import requests
from googleapiclient.errors import HttpError
import time

# API key (generata da Google Cloud Platform)
DEVELOPER_KEY = "AIzaSyDp-i5FsVmz0TP6J1cydVXMI8ZkFF9ct9Y"

# ID della playlist di meditazione
playlist_id = "PLLVbtOVkPSt996c5Vpgyr0SACSBt1tt9-"

# YouTube API service
YOUTUBE_API_SERVICE_NAME = "youtube"
YOUTUBE_API_VERSION = "v3"

def download_mp3_url(video_url):
    ydl_opts = {
        'format': 'bestaudio/best',
        'postprocessors': [{
            'key': 'FFmpegExtractAudio',
            'preferredcodec': 'mp3',
            'preferredquality': '192',
        }],
        'outtmpl': '%(id)s.%(ext)s',
        'noplaylist': True,
        'quiet': True
    }
    
    try:
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            info_dict = ydl.extract_info(video_url, download=False)
            for f in info_dict['formats']:
                if f['ext'] == 'm4a' or f['ext'] == 'webm':
                    return f['url']
        print(f"Non è stato possibile trovare un'opzione di solo audio per {video_url}.")
        return None
    except yt_dlp.utils.DownloadError as e:
        print(f"Errore durante il download MP3 da {video_url}: {e}")
        return None

def parse_duration(duration):
    # Utilizziamo una regex per estrarre ore, minuti e secondi
    match = re.match(r'PT(\d+H)?(\d+M)?(\d+S)?', duration).groups()
    hours = int(match[0][:-1]) if match[0] else 0
    minutes = int(match[1][:-1]) if match[1] else 0
    seconds = int(match[2][:-1]) if match[2] else 0
    total_seconds = hours * 3600 + minutes * 60 + seconds
    return total_seconds

def get_playlist_videos(playlist_id):
    youtube = build(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION, developerKey=DEVELOPER_KEY)
    attempts = 5  # Numero di tentativi in caso di errore

    try:
        # Recupera tutti i video della playlist
        playlist_items = []
        next_page_token = None
        while True:
            for attempt in range(attempts):
                try:
                    playlist_request = youtube.playlistItems().list(
                        part="snippet",
                        playlistId=playlist_id,
                        maxResults=10,  # Riduci il numero di risultati per richiesta
                        pageToken=next_page_token
                    )
                    playlist_response = playlist_request.execute()
                    playlist_items += playlist_response["items"]
                    next_page_token = playlist_response.get("nextPageToken")
                    break
                except HttpError as e:
                    if e.resp.status in [500, 503]:
                        print(f"Errore temporaneo del server, riprovo (tentativo {attempt + 1}/{attempts})")
                        time.sleep(5 + attempt * 5)  # Attendi più a lungo ad ogni tentativo
                    else:
                        raise
                except requests.exceptions.RequestException as e:
                    print(f"Errore di rete: {e}, riprovo (tentativo {attempt + 1}/{attempts})")
                    time.sleep(5 + attempt * 5)  # Attendi più a lungo ad ogni tentativo

            if not next_page_token:
                break

        # Recupera i dettagli di ogni video (compresa la durata)
        videos_with_details = []
        for video in playlist_items:
            video_id = video['snippet']['resourceId']['videoId']
            for attempt in range(attempts):
                try:
                    video_request = youtube.videos().list(
                        part='snippet,contentDetails',
                        id=video_id
                    )
                    video_response = video_request.execute()

                    # Estrai le informazioni necessarie
                    title = video_response['items'][0]['snippet']['title']
                    author = video_response['items'][0]['snippet']['channelTitle']
                    duration = video_response['items'][0]['contentDetails']['duration']
                    duration_seconds = parse_duration(duration)
                    video_url = f'https://www.youtube.com/watch?v={video_id}'

                    # Scarica l'URL MP3 utilizzando yt_dlp
                    mp3_url = download_mp3_url(video_url)

                    if mp3_url:
                        video_info = {
                            'title': title,
                            'author': author,
                            'duration': duration_seconds,
                            'video_url': video_url,
                            'mp3_url': mp3_url,
                            'tag': 'meditazione'
                        }
                        videos_with_details.append(video_info)
                    else:
                        print(f"Non è stato possibile aggiungere il video {title} alla lista.")
                    break
                except HttpError as e:
                    if e.resp.status in [500, 503]:
                        print(f"Errore temporaneo del server, riprovo (tentativo {attempt + 1}/{attempts})")
                        time.sleep(5 + attempt * 5)  # Attendi più a lungo ad ogni tentativo
                    else:
                        raise
                except requests.exceptions.RequestException as e:
                    print(f"Errore di rete: {e}, riprovo (tentativo {attempt + 1}/{attempts})")
                    time.sleep(5 + attempt * 5)  # Attendi più a lungo ad ogni tentativo

        return videos_with_details

    except Exception as e:
        print(f"Errore durante il recupero dei video della playlist: {e}")
        return None

def write_to_csv(videos, output_file):
    try:
        with open(output_file, 'w', newline='', encoding='utf-8') as csvfile:
            fieldnames = ['Title', 'Author', 'Duration (seconds)', 'Video URL', 'MP3 URL', 'Tag']
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
            writer.writeheader()

            for video in videos:
                writer.writerow({
                    'Title': video['title'],
                    'Author': video['author'],
                    'Duration (seconds)': video['duration'],
                    'Video URL': video['video_url'],
                    'MP3 URL': video['mp3_url'],
                    'Tag': video['tag']
                })

        print(f"I dati dei video della playlist sono stati salvati in {output_file}")

    except Exception as e:
        print(f"Errore durante la scrittura del file CSV: {e}")

if __name__ == "__main__":
    # Nome del file CSV di output
    output_file = "meditazione_mp3.csv"

    # Ottieni i video della playlist con dettagli
    playlist_videos = get_playlist_videos(playlist_id)

    if playlist_videos:
        # Scrivi i dati su CSV
        write_to_csv(playlist_videos, output_file)
        print(f"I dati dei video della playlist sono stati salvati in {output_file}")
    else:
        print("Impossibile recuperare i video della playlist.")
