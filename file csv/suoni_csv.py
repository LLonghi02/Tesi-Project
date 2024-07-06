from bs4 import BeautifulSoup
import requests
import csv

def scrape_spotify_playlist(playlist_url):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
    }
    response = requests.get(playlist_url, headers=headers)
    if response.status_code == 200:
        soup = BeautifulSoup(response.content, 'html.parser')
        tracks = soup.find_all('div', class_='tracklist-col name')
        
        playlist_tracks = []
        for track in tracks:
            title = track.find('span', class_='track-name').text.strip()
            artists = track.find('span', class_='artists-albums').text.strip()
            playlist_tracks.append({'Title': title, 'Artists': artists})
        
        return playlist_tracks
    else:
        print(f"Error fetching playlist: {response.status_code}")
        return None

def write_to_csv(tracks, output_file):
    with open(output_file, 'w', newline='', encoding='utf-8') as csvfile:
        fieldnames = ['Title', 'Artists']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        
        for track in tracks:
            writer.writerow(track)

if __name__ == "__main__":
    # URL della playlist Spotify
    playlist_url = "https://open.spotify.com/playlist/5oXi3GOp2dpixosacwQJQk?si=902fcddc77724227"
    
    # Nome del file CSV di output
    output_file = 'playlist_spotify.csv'
    
    # Esegui lo scraping dei dati della playlist
    playlist_tracks = scrape_spotify_playlist(playlist_url)
    
    # Scrivi i dati su CSV
    if playlist_tracks:
        write_to_csv(playlist_tracks, output_file)
        print(f"I dati dei brani della playlist sono stati salvati in {output_file}")
    else:
        print("Errore nello scraping della playlist.")
