# Spatial_Sound_with_Head_Tracking

In this project, sound field reconstruction with two loudspeakers is done using crosstalk cancellation and generalized head related transfer functions. The repository contains MATLAB live scripts to measure personalized crosstalk equalization filters and to playback spatialized sound while changing the direction of sounds in real time. There is also the option to use head tracking and account for changes in the head position. The live scripts contain detailed explanations of the code.

Equipment needed:
- sound card
- two loudspeakers
- two small microphones that can be inserted in the ear canal
- (Motion tracking system by optitrack)
- and various cables etc.

Content of the repository:
- Three matlab live scripts
	-> crosstalk_equalization.mlx
	-> moving_source_staionary_head.mlx
	-> moving_source_with_head_tracking.mlx
- Video tutorial to set up the head tracking
- Tools
	-> all functions that are called from the live scripts
- Signals
	-> contains anechoic music and speech
	-> music files convolved with personalized crosstalk cancellation 	   (equalized filters are also saved here)
- hrtf_set
	-> contains left and right HRTFs from dummy head KEMAR from various angles
	-> downloaded from https://sound.media.mit.edu/resources/KEMAR.html
- NatNet_SDK_4.0
	-> SDK to send data from Motive to matlab

The Crosstalk_Equalization script is to measure the impulse response from each speaker to each ear. The impulse responses are inverted and convolved with anechoic music. Before running the script, insert the microphones in the ear canals and change the name of the user. If needed, change the variables INPUT_ID and OUTPUT_ID. All available devices are listed after running the second section. Select the relevant devices and input the corresponding device IDs.
There are two demo scripts to playback spatialized sounds. The first one, moving_source_stationary_head.m works without the head tracking system. In a simple GUI the position of the sound can be changed with two sliders/text fields. Both the azimuth and elevation angle can be changed in real time. The HRTF set that is used to create the spatialized audio depends on the angles chosen by the user.
The script moving_source_with_head_tracking is a slightly modified version of the same script. Here, the motion tracking system detects the orientation of the head. This makes it possible to compensate for changes in head position when selecting the HRTF set. When using the version with head tracking, open the optitrack software and calibrate the cameras before running the script. To do so follow the instructions in the video. After that, run the script. The interface from matlab to optitrack software is then established automatically.


N.B. Since the crosstalk equalization is only done for one specific angle (0 degrees), this works for the moving_source_stationary_head.m demonstration, but it is not a true representation for moving_source_with_head_tracking.m. Here, the orientation of the head changes all the time, which means the equalization is no longer accuractly represented. However, this is still a better approximation than not using equalization since the sound is externalized successfully.  
