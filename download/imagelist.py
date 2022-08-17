from __future__ import print_function

import os.path

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
from googleapiclient.http import MediaIoBaseDownload

import json
import sys
import os.path

# If modifying these scopes, delete the file token.json.
SCOPES = ['https://www.googleapis.com/auth/drive.readonly']

class gClient:
    def __init__(self, creds):
        self.creds = creds

    def listFolder(self, name):
        cache = "cache_{}.json".format(name)
        if os.path.isfile(cache):
            print ('Loading from cache')
            with open(cache) as json_file:
                files = json.load(json_file)
        else:
            files = {}
            try:
                drive = build('drive', 'v3', credentials=self.creds)

                # Call the Drive v3 API

                nextToken = None
                while (True):
                    print ('Getting page of results')
                    results = drive.files().list(q = "'" + name + "' in parents", pageSize=10, fields="nextPageToken, files(id, name)", pageToken=nextToken).execute()
                    items = results.get('files', [])

                    if not items:
                        print('No files found.')
                    else:
                        for item in items:
                            files[item['name']] = item['id']

                    if 'nextPageToken' in results:
                        nextToken = results['nextPageToken']
                    else:
                        break
            except HttpError as error:
                # TODO(developer) - Handle errors from drive API.
                print(f'An error occurred: {error}')

            print ('Saving dir list to cache')
            with open(cache, 'w') as f:
                json.dump(files, f, indent=4)

        return files    

    def download(self, file_id, dest):
        drive = build('drive', 'v3', credentials=self.creds)
        with(open(dest,'wb')) as file:
            request = drive.files().get_media(fileId=file_id)
            downloader = MediaIoBaseDownload(file, request)
            done = False
            while done is False:
                status, done = downloader.next_chunk()
                print(F'Download {int(status.progress() * 100)}%.')

def main():
    """Shows basic usage of the Drive v3 API.
    Prints the names and ids of the first 10 files the user has access to.
    """
    if len(sys.argv) != 3:
        print ('Usage:\n\t{} [list_of_imgs.txt] [output_location]'.format(sys.argv[0]))
        sys.exit(0)

    creds = None
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    if os.path.exists('token.json'):
        creds = Credentials.from_authorized_user_file('token.json', SCOPES)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            # Need to create a project and download credentials: https://developers.google.com/workspace/guides/create-project
            flow = InstalledAppFlow.from_client_secrets_file('credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open('token.json', 'w') as token:
            token.write(creds.to_json())

    client = gClient(creds)
    GRI = client.listFolder('14I6F8-eEpPnlSS2ChkuLDauQ-BpM64tl')
    museum = client.listFolder('1ts-wWsHZur57UM5zjOPTmBdmz7zItRTx')

    with open(sys.argv[1]) as f:
        for line in f:
            found=False
            img = line.replace('\n','')
            fileId = ''
            if img in GRI:
                found=True
                print ("{}: {}".format(img,GRI[img]))
                fileId = GRI[img]
            if img.replace('tif','TIF') in museum:
                found=True
                fileId = museum[img.replace('tif','TIF')]
                print ("{}: {}".format(img,fileId))

            if not found:
                print ('Not found: "{}"'.format(img))
            else:    
                filename = os.path.join(sys.argv[2], img)
                if os.path.exists(filename):
                    print ('File already exists {}'.format(filename))
                else:
                    client.download(fileId, filename)


if __name__ == '__main__':
    main()

