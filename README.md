# Here's the EEC 201 course project of Chen Wang and Ken Yang.

## Welcome to our Course Project!

You can see the introduction of the project and see the results in this page.

Our team works on Project B. ([See the introduction to the project B in PDF version.](Project2019B.pdf))

My team members and contact infos:

Name | SID | E-mail
- | - | -
Chen Wang | 916712699 | wacwang@ucdavis.edu
Ken Yang | 916682693 | lsyang@ucdavis.edu

Here's are the intro to the project B:

***

## <center>B: Vocoder Project</center>

### I. Design and Originality

This is a friendly competition to see which team can deliver the best product. Your design MUST be original, i.e., built by your own team from scratch and tested extensively by yourself. This project is distributed with a honor pledge.

### II. Team Work 

Students in the class should form teams of 2 or 3 to complete this project. Each student MUST contribute significantly to the completion of the project and the report and the live demonstration. Each team must complete their own designs. Teams can discuss their ideas but MAY NOT exchange programs.

### III. Project-B Task 

<ol>
<li type='1'>Programming tasks: Design and implement an LPC vocoder and synthesizer in Matlab with GUI. For information on how to build GUI from Matlab, read Mathworks document.</li>
<li type='1'>Design specifications: The LPC-vocoder GUI must allow the user to:</li>

<ol>
<li type='a'>Retrieve a segment of voice recorded; Generate a spectrogram.</li>
<li type='a'>Pass the voice through LPC vocoder to generate a low rate output bits into a file (&lt;16k bit/s).</li>
<li type='a'>Save the bits in a local file and let the synthesizer to recover the voice.</li>
<li type='a'>Play back the synthesizer output and generate its spectrogram for comparison with (a).</li>
<li type='a'>Provide at least two ways of estimating the pitch of the voice signal. Compare the result of the two different pitch estimation.</li>
</ol>

<li type='1'>Tests and Demonstration: Each team will be asked to step in front of the class to demonstrate in 5 minutes their software interactively using GUI. The test requirements are:</li>

<ol>
<li type='a'>Record another student’s voice for the program to encode and decode;</li>
<li type='a'>Show the results on the effect of the vocoder and decoder at different code rates;</li>
<li type='a'>Test the program on a standard newscaster’s reporting and a popular song sung by one of the team members;</li>
<li type='a'>Test the program when two people are talking at the same time;</li>
<li type='a'>By simpler changing the estimated pitch, test to convert a female vocalist into a male voice and vice versa. </li>
</ol>

</ol>

### IV. Report Requirement

The report should be submitted in a form of a webpage with equations and figures and demonstrations of signal effects in time and frequency domain. You must thoroughly document your findings, including all assumptions, parameters and graphs that are used in your analysis. The report should also contain a description (using your own words) of the problem addressed and the approaches used. Your webpage should allow users to repeat some of your test examples. Provide the audio files used for testing.

### V. Presentation

There shall be a live presentation in class for all teams.

### VI. Literature Review to Get Started
Vocoder is how human speech is currently encoded for cellular phones and a number of applications. For example, the famous LPC-10 is a government standard that encodes (with loss) human speech into 2.4kb/s data. Phase vocoder has a similar concept. It is used in the music industry (Auto-Tune).

For more information, visit these and other homepages:

[Reference1](http://www.data-compression.com/speech.html)

[Reference2](http://www.speech.cs.cmu.edu/comp.speech/Section3/Software/celp-3.2a.html)

[Reference3](http://searchworks.stanford.edu/view/2971130)

[Reference4](http://www.seas.ucla.edu/spapl/projects/ee214aW2002/1/report.html)

[Reference5](https://www.mathworks.com/matlabcentral/fileexchange/45321-lpc-vocoder)

[Reference6](https://www.mathworks.com/matlabcentral/fileexchange/52114-lpc-vocoder)

[Reference7](http://eeweb.poly.edu/iselesni/EL713/Speech/speech.pdf)

[Reference8](http://www.ece.ucsb.edu/Faculty/Rabiner/ece259/digital%20speech%20processing%20course/projects/LPC%20Vocoder%20Project.pdf)

[Reference9](http://www.ece.ucsb.edu/Faculty/Rabiner/ece259/digital%20speech%20processing%20course/Matlab%20Code/matlab_speech_2011_6tp.pdf)

(Last update: Feb. 22, 2019 15:40:00)
