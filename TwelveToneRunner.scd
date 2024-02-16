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

// Function to permutate the Series
q = { arg series;
	permute(series, rrand(0, series.size.factorial))
};





// Function to call the Synth
s = { arg out, freq, pSine, pSaw, pPulse, time; var x;  x = Synth(\Synth, [out: out, freq: freq, pSine: pSine, pSaw: pSaw, pPulse: pPulse, t: time]); };
)
)

// Routine to play the melody
(
r = Routine {
	// Declare Variables for the Melody Routine
	// Declare Variables for the Master Series the derivated Sequence,
	// and the Base Frequency
	var serie, sequence, base,

	// Variable for Counuter in Iterrate about Sequence
	n,

	// SoundColor Seetings for Master
	pSine, pSaw, pPulse,
	// Time to play
	time, timein;

	// Master Time
	time = 3;

	// Create a Sound Color for Master
	// Sine Amout
	pSine = rrand(0, 10)/10;
	// Sawthoth Amoúnt
	pSaw = rrand(0, 10)/10;
	// Pulse Amount
	pPulse = rrand(0, 10)/10;

	// Create an Array for the Series fro,0 to 11
	serie = Array.fill(12, { arg i; i  });

	// Choose a Base Frequency
	base = rrand(80, 2000);


	// Start the endless playing
	while {true}
	{
		// Call Permutation of Series for now Sequence to play
		sequence = q.value(serie);
		// Choose Duration of Sequence lenght
		time = max(min([time/2, time/3, time*2, time*3].choose, 18), 1/10);
		// Calculate Duration for each Event in the Sequence
		timein = time/sequence.size;
		// Initialize Counter for Position in Sequence
		n = 0;
		// Iterrate about the Sequence
		for(0, sequence.size-1)
		{
			// Call the Synth to play Event in Sequence
			s.value(0, base*pow(pow(2, 1/12), sequence[n]), pSine, pSaw, pPulse, timein);
			// Count Iterator Freuency up
			n = n+1;
			// Wait durtion of Event
			timein.wait;
		};
		sequence.postln;
	}
}
)

// Start and Stop the Melody Playing
r.play;
r.stop;
r.reset;

m.value(222);

	