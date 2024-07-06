import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
import csv

# Credenziali di accesso a Spotify
CLIENT_ID = '5bab76e76afb42e5a0717da5d107b109'
CLIENT_SECRET = 'c9b845a920914b05bd1ef32c6b9d9fbc'

# Crea un'istanza di Spotipy con le credenziali
client_credentials_manager = SpotifyClientCredentials(client_id=CLIENT_ID, client_secret=CLIENT_SECRET)
sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)
client_credentials_manager = SpotifyClientCredentials(client_id=CLIENT_ID, client_secret=CLIENT_SECRET)
sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)

def get_playlist_tracks(playlist_id):
    # Estrai l'ID della playlist dall'URL
    playlist_id = playlist_id.split('/')[-1].split('?')[0]

    results = sp.playlist_tracks(playlist_id)
    tracks = results['items']
    
    while results['next']:
        results = sp.next(results)
        tracks.extend(results['items'])
    
    return tracks

def write_to_csv(tracks, output_file):
    with open(output_file, 'w', newline='', encoding='utf-8') as csvfile:
        fieldnames = ['Title', 'Artist(s)', 'Album', 'Duration (ms)', 'Track URL']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        
        for track in tracks:
            track_info = {
                'Title': track['track']['name'],
                'Artist(s)': ', '.join([artist['name'] for artist in track['track']['artists']]),
                'Album': track['track']['album']['name'],
                'Duration (ms)': track['track']['duration_ms'],
                'Track URL': track['track']['external_urls']['spotify']
            }
            writer.writerow(track_info)

if __name__ == "__main__":
    # ID della playlist di Spotify (dal link fornito)
    playlist_id = 'https://open.spotify.com/playlist/5oXi3GOp2dpixosacwQJQk?si=902fcddc77724227'

    # Nome del file CSV di output
    output_file = 'suoni.csv'

    # Ottieni i brani della playlist
    playlist_tracks = get_playlist_tracks(playlist_id)

    # Scrivi i dati su CSV
    write_to_csv(playlist_tracks, output_file)

    print(f"I dati dei brani della playlist sono stati salvati in {output_file}")