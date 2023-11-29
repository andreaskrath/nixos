# NixOS
This repository contains my NixOS configuration files.

As I use the same configuration across multiple machines, the focus is to create a configuration that shares as much between machines as possible.
This is found in the [shared](/shared) directory.
The [hosts](/hosts) directory contains multiple machines and the specific additions and modifications to the shared configuration.

An additional focus is to allow the repository to be up-to-date on all my machines while not containing local untracked/uncommited changes for the configuration to work, as this would be a hassle to keep track of.
Instead, the configuration for a given machine is symlinked into the root of the directory, after which a normal `sudo nixos-rebuild switch` or `sudo nixos-rebuild boot` will build the desired configuration.

# Considerations
Personally, I am not a big fan of some of the file splitting this configuration leads to, as some of the host specific configuration files are only a couple of lines long and modify a single option.
However, I do think that this structure allows for additions to be easy and rather simply, if further machines are added to the host list.
