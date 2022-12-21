function AudioDeviceInfo()
disp(' ');

devinfo = audiodevinfo ();

disp('INPUT DEVICES: [ID] NAME ')

for cc = 1:length(devinfo.input)
  
  input_id = devinfo.input(cc).ID;
  input_name = devinfo.input(cc).Name;
  disp([ '[' num2str(input_id) '] ' input_name])
  
end

%keyboard

disp(' ');
disp(' ');

disp('OUTPUT DEVICES: [ID] NAME ')
for cc = 1:length(devinfo.output)
  
  output_id = devinfo.output(cc).ID;
  output_name = devinfo.output(cc).Name;
  disp(['[' num2str(output_id) '] ' output_name])
  
end

disp('')

%keyboard


    
