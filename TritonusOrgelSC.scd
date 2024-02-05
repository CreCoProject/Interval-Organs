// Syntdef for a very esay Synth
// Input Parameter:
// out : Output Chanell for Audio
// freq : Frequency to play
// pSine, pSaw, pPulse: Amount of the different Sources to Audio Output
(
SynthDef(\Synth, { |out, freq, pSine, pSaw, pPulse, t|
	var sig, sigSine, sigSaw,sigPulse;
	// Sine Source
	sigSine = SinOsc.ar(freq, 0, pSine);
	// Sawthoth Source
	sigSaw = Saw.ar(freq, pSaw);
	// Pulse Source
	sigPulse = Pulse.ar(freq, 0.5, pPulse);
	// Mixing of final Result
	sig = sigSine + sigSaw + sigPulse;
	sig = sig * EnvGen.kr( Env.triangle(t, 1), doneAction: 2);
    Out.ar(out, sig )
}).add;
)

// Controll Call for the Synth
x = Synth(\Synth, [freq: 440, pSine: rrand(0, 1), pSaw: rrand(0, 1), pPulse: rrand(0, 1), t: 0.1]);
x. free;

// Interval Transforming Functions
(
// Transform Tritouns up or down
f = { arg freq; [freq*sqrt(2), freq/sqrt(2)].choose };


// Function to call the Synth
s = { arg freq, pSine, pSaw, pPulse, time; var x;  x = Synth(\Synth, [freq: freq, pSine: pSine, pSaw: pSaw, pPulse: pPulse, t: time]); time.wait};
)

f.value(440);

// Routine to play the melody
(
r = Routine {
	// Declare Variables for the Melody Routine
	// The Frequency to play
	var freq,
	// SoundColor Seetings
	pSine, pSaw, pPulse,
	// Time to play
	time;

	// Seeting Main Frequency
	freq = 440;

	time = 3;

	// Create a Sound Color
	// Sine Amout
	pSine = rrand(0, 1);
	// Sawthoth Amoúnt
	pSaw = rrand(0, 1);
	// Pulse Amount
	pPulse = rrand(0, 1);

	// Start the endless playing
	while {true}
	{
		// for the actual Bar choose a Quintal or Quartal diffeent Pitch
		freq = max(min(10000, f.value(freq)),40);

		time = [time*2, time/2].choose;

		s.value(freq, pSine, pSaw, pPulse, time);


	}
}
)

// Start and Stop the Melody Playing
r.play;
r.stop;
r.reset;