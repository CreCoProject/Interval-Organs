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
f = { arg freq; [freq*5/4, freq*4/5].choose };

// Function to choose the small Third
g = { arg freq; [freq*6/5, freq*5/6].choose };

// Function to call the Synth
s = { arg out, freq, pSine, pSaw, pPulse, time; var x;  x = Synth(\Synth, [out: out, freq: freq, pSine: pSine, pSaw: pSaw, pPulse: pPulse, t: time]); out.postln; freq.postln};
)
)

// Routine to play the melody
(
r = Routine {
	// Declare Variables for the Melody Routine
	// The Frequency to play Master and Slave
	var freq, freqAc,

	// SoundColor Seetings for Master
	pSine, pSaw, pPulse,
	// SoundColor Seetings for Slave
	pSineS, pSawS, pPulseS,
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

	// Create a Sound Color for Slave
	// Sine Amout
	pSineS = rrand(0, 1);
	// Sawthoth Amoúnt
	pSawS = rrand(0, 1);
	// Pulse Amount
	pPulseS = rrand(0, 1);

	// Start the endless playing
	while {true}
	{
		// Call Calculation of the Melody
		freq = min(max(f.value(freq), 40), 10000);
		// Call Calculartion of the Harmony
		freqAc = g.value(freq);

		// Choose new playing time
		time = [time*2, time/2].choose;

		// Call Synths
		// Master to play Melody
		s.value(0, freq, pSine, pSaw, pPulse, time);
		// Slave to play Harmony
		s.value(1, freqAc, pSineS, pSawS, pPulseS, time);

		time.wait;

	}
}
)

// Start and Stop the Melody Playing
r.play;
r.stop;
r.reset;