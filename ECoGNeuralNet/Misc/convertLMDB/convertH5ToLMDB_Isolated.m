% Matlab code

% This is the H5 file version where test and training samples are already pre-split
path = '/home/matt/Projects/Data/ECoG/ExpandedIsolatedGaussian/';
h5Name = strcat(path, 'Expanded_ECoG_285Isolated_GaussianNoise.h5');
LMDBTest = strcat(path, 'ECoG_test');
LMDBTrain = strcat(path, 'ECoG_train');

X_test = h5read(h5Name, '/Xhigh gamma');
y_test = h5read(h5Name, '/y');
X_train = h5read(h5Name, '/Xhigh gamma isolated');
y_train = h5read(h5Name, '/y isolated');
X_test = permute(X_test, [1, 2, 4, 3]); % add dimension
X_train = permute(X_train, [1, 2, 4, 3]); % add dimension
y_test = y_test'; % transpose
y_train = y_train'; % transpose

% Cast data types
X_test = single(X_test); % cast from uint8 to float
y_test = int32(y_test);
X_train = single(X_train);
y_train = int32(y_train);

% Keep only these ECoG "pixels"
X_test = reshape(X_test, 1, 258*86, 1, size(X_test, 4)); % Make X 1D
X_train = reshape(X_train, 1, 258*86, 1, size(X_train, 4));
reducedInputs = [39, 257, 388, 422, 434, 552, 611, 626, 834, 1066, 1074, 1087, 1110, 1361, 1369, 1398, 1415, 1428, 1477, ...
    1572, 1580, 1586, 1622, 1687, 1710, 1793, 1826, 1872, 1873, 1873, 1886, 1912, 1918, 1995, 2089, 2119, 2127, 2149, 2209, ...
    2209, 2220, 2240, 2383, 2603, 2608, 2677, 2788, 2805, 2967, 3029, 3122, 3169, 3280, 3345, 3399, 3416, 3418, 3418, 3554, ...
    3639, 3737, 3746, 3982, 3989, 4030, 4064, 4079, 4256, 4267, 4401, 4434, 4478, 4501, 4635, 4687, 4762, 4780, 4781, 4851, ...
    4856, 4857, 4861, 4958, 5032, 5226, 5281, 5352, 5459, 5540, 5549, 5709, 5738, 5753, 5767, 5795, 5807, 5875, 5939, 5950, ...
    6004, 6010, 6012, 6018, 6028, 6035, 6064, 6095, 6219, 6246, 6267, 6297, 6297, 6310, 6313, 6335, 6436, 6553, 6567, 6590, ...
    6711, 6728, 6785, 6842, 6846, 6862, 6990, 7072, 7090, 7140, 7302, 7309, 7315, 7342, 7343, 7356, 7655, 7714, 7832, 7909, ...
    8069, 8075, 8294, 8377, 8405, 8442, 8479, 8498, 8542, 8577, 8590, 8592, 8603, 8611, 8612, 8615, 8616, 8623, 8624, 8626, ...
    8636, 8650, 8652, 8654, 8659, 8668, 8735, 8737, 8752, 8802, 8819, 8871, 8884, 8892, 8895, 8897, 8918, 8919, 8926, 8951, ...
    8991, 9129, 9267, 9277, 9331, 9333, 9371, 9375, 9398, 9405, 9420, 9421, 9463, 9498, 9522, 9625, 9635, 9649, 9676, 9704, ...
    9759, 9860, 9882, 9901, 9946, 9994, 10018, 10173, 10195, 10245, 10362, 10378, 10379, 10524, 10558, 10660, 10669, 10672, ...
    10701, 10718, 10719, 10732, 10804, 10820, 10835, 10879, 10881, 10900, 10930, 10931, 10949, 10954, 10955, 10955, 10955, ...
    10965, 10967, 10967, 10967, 10971, 10972, 10974, 10975, 10984, 10985, 10995, 10997, 11008, 11010, 11017, 11019, 11027, ...
    11043, 11094, 11140, 11173, 11188, 11211, 11223, 11232, 11235, 11236, 11250, 11258, 11273, 11281, 11315, 11410, 11413, ...
    11435, 11488, 11512, 11514, 11558, 11573, 11630, 11693, 11694, 11704, 11710, 11718, 11720, 11720, 11728, 11729, 11736, ...
    11739, 11741, 11746, 11755, 11761, 11765, 11783, 11796, 11811, 11817, 11829, 11838, 11843, 11945, 11949, 11965, 12009, ...
    12034, 12043, 12048, 12107, 12167, 12243, 12253, 12257, 12271, 12302, 12359, 12362, 12408, 12473, 12558, 12687, 12732, ...
    12741, 12865, 12958, 12984, 12990, 13055, 13055, 13060, 13081, 13136, 13153, 13192, 13213, 13316, 13358, 13360, 13388, ...
    13454, 13479, 13501, 13534, 13553, 13605, 13643, 13755, 13769, 13769, 13771, 13818, 13825, 13841, 13854, 13861, 13865, ...
    13943, 13982, 13993, 14002, 14032, 14062, 14077, 14084, 14191, 14201, 14232, 14238, 14253, 14256, 14274, 14280, 14288, ...
    14296, 14298, 14333, 14395, 14448, 14515, 14550, 14555, 14558, 14571, 14586, 14586, 14592, 14600, 14612, 14639, 14650, ...
    14776, 14780, 14801, 14838, 14844, 14861, 14930, 14982, 15238, 15314, 15314, 15530, 15715, 15743, 15847, 16057, 16076, ...
    16089, 16106, 16111, 16117, 16119, 16287, 16341, 16547, 16552, 16560, 16583, 16587, 16588, 16589, 16634, 16635, 16641, ...
    16677, 16697, 16704, 16711, 16759, 16791, 16827, 16836, 16841, 16879, 16891, 16899, 16914, 16959, 16963, 16967, 17020, ...
    17071, 17107, 17183, 17192, 17223, 17225, 17303, 17326, 17363, 17372, 17375, 17389, 17406, 17443, 17445, 17517, 17566, ...
    17572, 17590, 17600, 17610, 17610, 17625, 17641, 17642, 17647, 17652, 17656, 17664, 17670, 17673, 17674, 17690, 17690, ...
    17695, 17704, 17710, 17727, 17730, 17732, 17737, 17737, 17738, 17745, 17752, 17787, 17822, 17848, 17881, 17976, 18031, ...
    18045, 18069, 18115, 18117, 18156, 18218, 18242, 18272, 18365, 18417, 18448, 18474, 18624, 18654, 18727, 18730, 18741, ...
    18865, 18874, 18944, 18963, 19000, 19032, 19048, 19108, 19109, 19129, 19156, 19169, 19173, 19260, 19304, 19327, 19330, ...
    19359, 19364, 19365, 19366, 19416, 19417, 19445, 19493, 19565, 19573, 19575, 19582, 19607, 19640, 19657, 19704, 19706, ...
    19740, 19741, 19766, 19777, 19782, 19797, 19857, 19913, 19915, 19920, 19922, 19930, 19967, 19978, 19978, 19983, 20027, ...
    20058, 20081, 20157, 20175, 20178, 20225, 20281, 20335, 20360, 20402, 20409, 20433, 20436, 20731, 20776, 20978, 21043, ...
    21054, 21123, 21136, 21180, 21229, 21326, 21396, 21406, 21453, 21460, 21475, 21515, 21535, 21579, 21598, 21744, 21780, ...
    21792, 21840, 21967, 22000, 22013, 22121, 22121, 22144, 22165];
X_test = X_test(:,reducedInputs+1,:,:);
X_train = X_train(:,reducedInputs+1,:,:);
X_test = reshape(X_test, 20, 30, 1, size(X_test, 4)); % Make X 2D
X_train = reshape(X_train, 20, 30, 1, size(X_train, 4));

% Randomly shuffle data order.
nSamples_test = size(X_test, 4);
perm_test = randperm(nSamples_test);
X_test = X_test(:,:,:,perm_test);
y_test = y_test(perm_test);
nSamples_train = size(X_train, 4);
perm_train = randperm(nSamples_train);
X_train = X_train(:,:,:,perm_train);
y_train = y_train(perm_train);

if ~exist(LMDBTest, 'dir')
    mkdir(LMDBTest);
end
clear write_lmdb
write_lmdb(LMDBTest, X_test, y_test, 'single');

if ~exist(LMDBTrain, 'dir')
    mkdir(LMDBTrain);
end
clear write_lmdb
write_lmdb(LMDBTrain, X_train, y_train, 'single');