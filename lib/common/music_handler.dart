import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MusicHandler extends BaseAudioHandler {
  final AudioPlayer _audioPlayer;

  MusicHandler(this._audioPlayer) {
    _audioPlayer.playbackEventStream.listen(_broadcastState);
  }

  Future<void> setUrl(String url) async {
    await _audioPlayer.setUrl(url);
  }

  @override
  Future<void> play() async {
    await _audioPlayer.play();
  }

  @override
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  @override
  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void _broadcastState(PlaybackEvent event) {
    final playing = _audioPlayer.playing;
    final status = playing ? AudioProcessingState.ready : AudioProcessingState
        .idle;

    playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.pause,
          MediaControl.stop
        ],
        systemActions: const {
          MediaAction.seek,
        },
        androidCompactActionIndices: [0, 1],
        processingState: status,
        playing: playing,
        updatePosition: _audioPlayer.position,
        bufferedPosition: _audioPlayer.bufferedPosition,
        speed: _audioPlayer.speed
    ));
  }
}