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
f = { ~freq = Array.fill(12, { rrand(40, 5000) });
	  ~time = Array.fill(12, { rrand(1,180)/10 });
	  ~pSine = Array.fill(12, { rrand(1, 10)/10 });
	  ~pSaw = Array.fill(12, { rrand(1, 10)/10 });
	  ~pPulse = Array.fill(12, { rrand(1, 10)/10 });


};



// Function to call the Synth
s = { arg out, freq, pSine, pSaw, pPulse, time; var x;  x = Synth(\Synth, [out: out, freq: freq, pSine: pSine, pSaw: pSaw, pPulse: pPulse, t: time]); out.postln; freq.postln};
)
)

// Routine to play the melody
(
r = Routine {
	var n, time;
	f.value();
	while{true}{
		n = rrand(0, 11);
		time = ~time[n];
		s.value(0, ~freq[n];, ~pSine[n], ~pSaw[n], ~pPulse[n], time);
		time.wait;
	}
}
)

// Start and Stop the Melody Playing
r.play;
r.stop;
r.reset;

f.value();
~freq;