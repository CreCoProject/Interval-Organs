// Synth who plays the Melody
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

(
// Function to choose the large Thid
f = { arg freq;
	var q = pow(pow(2.0,(1/1200)), 685.7);
	q.postln;
	[freq*q, freq/q].choose };



// Function to call the Synth
s = { arg out, freq, pSine, pSaw, pPulse, time; var x;  x = Synth(\Synth, [out: out, freq: freq, pSine: pSine, pSaw: pSaw, pPulse: pPulse, t: time]); out.postln; freq.postln};
)
)

// Routine to play the melody
(
r = Routine {
	// Declare Variables for the Melody Routine
	// The Frequency to play
	var freq,

	// SoundColor Seetings for Master
	pSine, pSaw, pPulse,
	// Time to play
	time;

	// Seeting Main Frequency
	freq = 440;

	time = 3;

	// Create a Sound Color for Master
	// Sine Amout
	pSine = rrand(0, 1);
	// Sawthoth Amoúnt
	pSaw = rrand(0, 1);
	// Pulse Amount
	pPulse = rrand(0, 1);

	// Start the endless playing
	while {true}
	{
		// Call Calculation of the Melody
		freq = min(max(f.value(freq), 100), 10000);

		// Choose new playing time
		time = [time*2, time/2].choose;

		// Call Synths
		s.value(0, freq, pSine, pSaw, pPulse, time);

		time.wait;

	}
}
)

// Start and Stop the Melody Playing
r.play;
r.stop;
r.reset;