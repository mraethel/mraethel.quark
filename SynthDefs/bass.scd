SynthDef(\mbass, { arg out, freq = 440, pan;
  var ampenvbass, bass;

  ampenvbass = Env.asr(0.5, 1, 0.5);
  bass = SinOsc.ar(freq, 0, EnvGen.kr(ampenvbass));

  Out.ar(out, DirtPan.ar(bass, ~dirt.numChannels, pan));
  
  DetectSilence.ar(In.ar(bass), doneAction: Done.freeSelf);
}).add;
