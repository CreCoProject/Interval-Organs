(
SynthDef(\freqAcompainer, { |out, ratio|
    var s;
    s = PitchShift.ar(
        SoundIn.ar([0, 1]),    // stereo audio input
        0.1,             // grain size
        ratio,    // Pitch Schift Ratio
        0,                 // pitch dispersion
        0.004            // time dispersion
    );
	// Second Stero audio input and add to shifted Signal
	s = s + SoundIn.ar([0, 1]);
	Out.ar([0, 1], s);
}).add;
)

x = Synth(\freqAcompainer, [out: [0,1], ratio: 5/4 ]);