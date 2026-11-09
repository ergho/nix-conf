#!/usr/bin/env fish

# Config
set -g cert_dir "certs"

# Helper Functions

# Checks if file is currently sops encrypted
function is_encrypted -argument file
  if test -f "$file"
    # Sops encrypted files always contains  metadata with 'sops:'
    grep -q "sops:" "$file"
    return $status
  else
    return 1
  end
end

# Cleans up and ensure that nothing relevant is left unencrypted in $cert_dir
function cleanup
  set -l cert_files (find "$cert_dir" -type f \( -name "*.crt" -o -name "*.pem" \))
  for file in $cert_files
    if test -f "$file"
      if not is_encrypted "$file"
        set_color cyan
        echo "Re-encrypting $file"
        set_color normal
        sops -e -i "$file"
      end
    end
  end
end


# Validate that $cert_dir exists

if not test -d "$cert_dir"
  set_color red
  echo "Error: `$cert_dir` not found"
  set_color normal
  exit 1
end

# Trap EXIT to ensure state is kept encrypted if the script crashes or is interrupted
trap cleanup EXIT

# Main part of script

# Find all .crt and .pem files inside $cert_dir 
set -l cert_files (find "$cert_dir" -type f \( -name "*.crt" -o -name "*.pem" \))

if test (count $cert_files) -eq 0
  set_color yellow
  echo "Warning: no cert files found in $cert_dir"
  set_color normal
  exit 1
end


# Process files
echo "Processing certs in $cert_dir"

for file in $cert_files
  if is_encrypted "$file"
    echo "Decrypting $file"
    sops -d -i "$file"
  else
    set_color yellow
    echo "NOTE: $file was already decrypted, leaving it as is."
    set_color normal
  end
end

# NIXOS Steps

echo "Running nixos rebuild"

sudo nixos-rebuild switch --flake . $argv
set -l rebuild_status $status


# Trigger cleanup on success
cleanup

# Remove trap, so cleanup isn't triggered a second time on exit
trap - EXIT

if test $rebuild_status -eq 0
  set_color green
  echo "Done!"
  set_color normal
else
  set_color red
  echo "Rebuild failed, with exit code $rebuild_status"
  set_color normal
  exit $rebuild_status
end
