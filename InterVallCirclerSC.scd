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
// Transform Quint up or down
f = { arg freq; [freq*2/3, freq*3/2].choose };

// Transform Quart up or Down
q = { arg freq; [freq*3/4, freq*4/3].choose };

// Transform major Terz up or down
m = { arg freq; [freq*4/5, freq*5/4].choose };

// Transform minor Terz up or down
n = { arg freq; [freq*5/6, freq*6/5].choose };

// Function to call the Synth
s = { arg freq, pSine, pSaw, pPulse, time; var x;  x = Synth(\Synth, [freq: freq, pSine: pSine, pSaw: pSaw, pPulse: pPulse, t: time]); time.wait};
)

// Routine to play the melody
(
r = Routine {
	// Declare Variables for the Melody Routine
	// Master Frequency and Playing Frequency
	var freqm, freqp,
	// SoundColor Seetings
	pSine, pSaw, pPulse,
	// Rhythmic Values old and new Rhythmical Divisions
	dofq, olddofq,
	// Time to play Bar and Note
	mainTime, inTime;

	// Seeting Main Frequency
	freqm = 440;

	// Initalise Rhythmical Values
	// Setting first Bar to one Note
	dofq = 1;
	// Intialise old Division with new Divsion
	olddofq = dofq;
	// Setting Start Bar Time to 3 Seconds
	mainTime = 3;
	inTime = mainTime;

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
		postln("Test");
		// for the actual Bar choose a Quintal or Quartal diffeent Pitch
		freqm = max(min(10000, [f.value(freqm), q.value(freqm)].choose),40);

		// Choose Style of Rhythmical Change
		if ( [true, false].choose )
		// If new Divsion is choosed
		{
			// Save actual Divsion to old Divsion
			olddofq = dofq;
			// Coose new Elements in Bar
			dofq = rrand(1, 7).round(1);
			// Recreate time for Notes in Bar
			mainTime = mainTime * (olddofq / dofq);
			inTime = mainTime / dofq;

		}
		// Choosen Style for Duration Change
		{
			mainTime = mainTime; // [ mainTime/3, mainTime/2, mainTime*2, mainTime*3].choose;
			inTime = mainTime / dofq;
			inTime.postln;
		};

		// Set playing Pitch to main Pitch
		freqp = freqm;

		// Iterate about Notes in Bar
		for(1, dofq)
			{
			// Choose a new Pitch for the playing Note
			freqp = max(40, min(10000, [m.value(freqp), n.value(freqp)].choose));
			// Call the Synth with the actual Pitch
			s.value(freqp, pSine, pSaw, pPulse, inTime );
			// wait for the Rhythmical Duratio of the Note
			// mainTime.wait;
			// Stop and remove the actual Synth.
			// ~x.free
			inTime.wait;
			}
	}
}
)

// Start and Stop the Melody Playing
r.play;
r.stop;