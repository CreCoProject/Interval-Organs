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
f = { arg freq, v;
	// Calculate the Interval as one Key in 19th Division
	q = pow(2,(1/12))**rrand(v,12+v);
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
	// The Frequencys to play
	var freq1, freq2,

	// SoundColor Seetings for Master
	pSine, pSaw, pPulse,
	// Time to play
	time;

	// Seeting Main Frequency
	freq1 = 440;
	freq2 = 466.16;

	time = 3;

	// Create a Sound Color for Master
	// Sine Amout
	pSine = rrand(0, 10)/10;
	// Sawthoth Amoúnt
	pSaw = rrand(0, 10)/10;
	// Pulse Amount
	pPulse = rrand(0, 10)/10;

	// Start the endless playing
	while {true}
	{
		// Call Calculation of the Melody
		freq1 = min(max(f.value(freq1, 0), 100), 10000);
		freq2 = min(max(f.value(freq2, 2), 100), 10000);

		// Choose new playing time
		time = [time*2, time/2].choose;

		// Call Synths
		s.value(0, freq1, pSine, pSaw, pPulse, time);
		s.value(1, freq2, pSine, pSaw, pPulse, time);

		time.wait;

	}
}
)

// Start and Stop the Melody Playing
r.play;
r.stop;
r.reset;

rrand(0,10)/10;