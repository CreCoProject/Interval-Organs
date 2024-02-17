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


// Function to choose the Series for the Parameters

f = {
	// Series of Frequencys
	~freq = Array.fill(12, { rrand(40, 5000) });
	// Series of Durations
	~time = Array.fill(12, { rrand(1,90)/10 });
	// Series of Power of Sine Source
	~pSine = Array.fill(12, { rrand(1, 10)/10 });
	// Series of Power of Sawthoth Source
	~pSaw = Array.fill(12, { rrand(1, 10)/10 });
	// Series of Power of Square Source
	~pPulse = Array.fill(12, { rrand(1, 10)/10 });

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

	// Declare Variable to access Time
	time,

	// SoundColor Seetings for Master
	pSine, pSaw, pPulse;

	// Create a Sound Color for Master
	// Sine Amout
	pSine = rrand(0, 10)/10;
	// Sawthoth Amoúnt
	pSaw = rrand(0, 10)/10;
	// Pulse Amount
	pPulse = rrand(0, 10)/10;

	// Create an Array for the Series fro,0 to 11
	serie = Array.fill(12, { arg i; i  });

	f.value();


	// Start the endless playing
	while {true}
	{
		// Call Permutation of Series for now Sequence to play
		sequence = q.value(serie);
		// Initialize Counter for Position in Sequence
		n = 0;
		// Iterrate about the Sequence
		for(0, sequence.size-1)
		{
			time = ~time[sequence[n]];
			// Call the Synth to play Event in Sequence
			s.value(0, ~freq[sequence[n]], ~pSine[sequence[n]], ~pSaw[sequence[n]], ~pPulse[sequence[n]], time);
			// Count Iterator Freuency up
			n = n+1;
			// Wait durtion of Event
			time.wait;
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

	Array.fill(12, { arg i; i  });