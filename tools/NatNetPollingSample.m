function [angle_y] = NatNetPollingSample(data)

    qx = data.RigidBodies( 1 ).qx;
    qw = data.RigidBodies( 1 ).qw;
    qy = data.RigidBodies( 1 ).qy;
    qz = data.RigidBodies( 1 ).qz;

    angles = rad2deg(quat2eul([qw, qx, qy, qz]));

    angle_y = -1*angles(2);

end
