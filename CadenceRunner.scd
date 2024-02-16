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
// Function to choose the Function Note
m = { arg freq;
	// Declare Memory for Master Interval
	// and Octaviation Interval
	var mf, oct;
	// Choose a Master Interval
	mf = [2/3, 3/4].choose;
	// Choose an Octaviation Interval
	oct = [1/2, 1, 2/1].choose;
	// Calculate Resulting next Functin Note
	freq * oct * mf;
};

// Function to choose slave Note
q = { arg freq;
	// Calculate next Slave Note
	[freq*4.0/5, freq*5.0/4, freq*6.0/5, freq*5.0/6].choose;
};

// Function to choose the next Basic Bar Note
a = { arg freq;
	// Calculate the next Basic Bar Note
	[freq*2/3, freq*3/2].choose;
};



// Function to call the Synth
s = { arg out, freq, pSine, pSaw, pPulse, time; var x;  x = Synth(\Synth, [out: out, freq: freq, pSine: pSine, pSaw: pSaw, pPulse: pPulse, t: time]); time.postln};
)
)

// Routine to play the melody
(
r = Routine {
	// Declare Variables for the Melody Routine
	// The Frequencys to play Master Frequency
	// Frequency for Main Function
	// Frequency for slave Frequency
	var freq, freqm, freqn,

	// Variable for Clausels in Bar
	n,

	// SoundColor Seetings for Master
	pSine, pSaw, pPulse,
	// Time to play
	time, timem, timen;

	// Seeting Main Frequency
	freq = 440;

	// Master Time
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
		// Choose Number of Clausels in Bar
		n = rrand(1,6);
		// Choose a new time for the next Bar
		time = [time*2, time, time/2].choose;
		// Save Time in Range
		time = min(max(time, 0.1), 9);
		// Calculate Time for Clausel in Bar
		timem = time/n;
		// Choose a Base Note for the actual Bar
		freq = a.value(freq);
		// Save the master Frequency
		freq = min(max(freq, 80), 20000);
		for(1, n){
			// Call Function to calculate the Function Note
			freqm = m.value(freq);
			// Choose a Time for the slave Note
			timen = rrand(1, 8)/8*timem;
			// Call Function to calczulate the Slave Note
			freqn = q.value(freqm);
			// Call Synth for slave Note
			s.value(0, freqn, pSine, pSaw, pPulse, timen);
			// Wait for Duration of slave Note
			timen.wait;

			// Call Synth for Function Note
			s.value(0, freqm, pSine, pSaw, pPulse, timem-timen);
			// Wait for Duration of Function Note
			(timem-timen).wait;
		}

	}
}
)

// Start and Stop the Melody Playing
r.play;
r.stop;
r.reset;

m.value(222);