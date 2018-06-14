## Mscanalysis

Mscanalysis is a set of tools for determining characteristics of Audio and returning them to a user in a meaningful way.

## Install

Make sure aubio is installed

```
sudo apt-get install aubio-tools libaubio-dev libaubio-doc python-dev build-essential
sudo pip install aubio
```

Run bundle to install necessary dependencies.

```
bundle install
```

### NOW with Sinatra powered API

Currently in dev

#### Setup database

```
rake db:migrate
```

Run the server

```
rerun 'ruby -Ilib application.rb'
```

### Current simple version

After you have spun up the server, you can visit ```http://localhost:4567/upload``` and upload an audio file.

To view all analyzed files go to ```http://localhost:4567/songs```

No full proper views yet.

### From command line - while Server is running

Make a request to the current song key endpoint

```
curl -v -F "data=@demo_files/02 - Antikue - Into Jomsom.wav" http://localhost:4567/song_key
```

### Use the script in IRB.

#### Get Song Key

Open ```get_song_key.rb``` Change @file to your chosen filename

Run:

```sh
ruby get_song_key.rb
```

The output will guess the key of the song.

#### Get Song Tempo

```ruby
@song = SongTempo.new '../demo_files/01 - Opening Sequence - Outside (Raining).mp3'
@song.tempo
@song.tempo_float
```

This will output the tempo of the song.

## Dependencies / Requirements

Aubio

## Development

Currently undergoing heavy development.

## Dependencies

### Essentia

This software relies on the awesome [Essentia](https://github.com/MTG/essentia) software. All binaries that are needed canbe found in the /bin/ folder along with a copy of the license for Essentia's work.

### Aubio - depreciating

You are only required to install the standard Aubio binary to use these scripts, you may obtain it and the source code from:
[Github](https://github.com/aubio/aubio/)


# Implementations

Going back to square one as Essentia can help with pretty much all of these.


## DONE

### Musical Key

Using Aubio

## TODO - Need help integrating these!

### Danceability

### Duration

### Energy

### Loudness

### Tempo

Possibility to use MiniBPM (https://bitbucket.org/breakfastquay/minibpm)

### Time Signature
