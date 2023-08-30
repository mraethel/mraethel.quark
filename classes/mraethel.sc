Mraethel {
  *new { ^super.new.init }

  init { ~dirt.loadSynthDefs("../SynthDefs".resolveRelative) }
}
