SynthDef(\mkick, { arg out, pan;
  var kick;
  var ampenvperc, modenvperc, perc;
  var ampenvbass, bass;
  
  kick = Bus.audio(s);

  ampenvperc = Env.perc(0.01, 0.05, 0.5);
  modenvperc = Env.perc(0, 0.05, 50.midicps);
  perc = SinOsc.ar(28.midicps + EnvGen.kr(modenvperc), mul: EnvGen.kr(ampenvperc));
  Out.ar(kick, perc);

  ampenvbass = Env.perc(0.01, 0.5, 0.5);
  bass = SinOsc.ar(32.midicps, mul: EnvGen.kr(ampenvbass));
  Out.ar(kick, bass);
  
  Out.ar(out, DirtPan.ar(In.ar(kick), ~dirt.numChannels, pan));

  DetectSilence.ar(In.ar(kick), doneAction: Done.freeSelf);
}).add;

SynthDef(\mhihat, { arg out, freq = 440, pan;
  var ampenvhihat, hihat;

  ampenvhihat = Env.perc(0, 0.1, 1, -5);
  hihat = LPF.ar(WhiteNoise.ar(), freq, EnvGen.kr(ampenvhihat));

  Out.ar(out, DirtPan.ar(hihat, ~dirt.numChannels, pan));
  
  DetectSilence.ar(In.ar(hihat), doneAction: Done.freeSelf);
}).add;

SynthDef(\msnare, { arg out, pan;
  var snare;
  var ampenvperc, modenvperc, perc;
  var ampenvwire, wire;

  snare = Bus.audio(s);

  ampenvperc = Env.linen(0, 0.05, 0.05, 0.5, 0);
  modenvperc = Env.perc(0, 0.005, 64.midicps, 0);
  perc = SinOsc.ar(46.midicps + EnvGen.kr(modenvperc), mul: EnvGen.kr(ampenvperc));
  Out.ar(snare, perc);

  ampenvwire = Env([0, 1, 0, 0.3, 0], [0, 0.005, 0.05, 0.1], releaseNode: 4);
  wire = WhiteNoise.ar(EnvGen.kr(ampenvwire));
  Out.ar(snare, wire);

  Out.ar(out, DirtPan.ar(In.ar(snare), ~dirt.numChannels, pan));

  DetectSilence.ar(In.ar(snare), doneAction: Done.freeSelf);
}).add;
