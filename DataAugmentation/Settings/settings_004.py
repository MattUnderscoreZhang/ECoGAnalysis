original_filename = "../../Data/ECoG/Original/EC2_blocks_1_8_9_15_76_89_105_CV_HG_align_window_-0.5_to_0.79_file_nobaseline.h5"
new_filename = "../../Data/ECoG/004.h5"
overwrite = False # whether it's ok to overwrite an existing output file
n_isolated_samples = 5 # samples to keep separate and not use in augmentation (will later be used as test samples)
total_samples_per_class = 500 # total number of samples we want to end up with for each CV pair
interpolation = True
gaussian_noise = False
gaussian_noise_sigma = 0.5
time_shifting = True
max_steps_timeshift = 10
amplitude_scaling = True
min_amplitude_scale = 0.5
max_amplitude_scale = 2
use_best_channels = True
trim = False
best_channels = [34, 27, 37, 36, 25, 38, 42, 33, 24, 23] # (ordered worst to best, but doesn't matter)
downsample_factor = 2
