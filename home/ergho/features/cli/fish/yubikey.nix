{ pkgs, ... }:
{
  programs.fish = {
    functions = {
      yubion = {
        description = "Load YubiKey PIV keys into ssh-agent via OpenSC";
        body = ''
          set -l pkcs11_provider ${pkgs.opensc}/lib/pkcs11/opensc-pkcs11.so
          if not test -r "$pkcs11_provider"
            echo "yubion: OpenSC PKCS#11 provider not found at $pkcs11_provider" >&2
            return 1
          end
          if not set -q SSH_AUTH_SOCK; or not test -S "$SSH_AUTH_SOCK"
              echo "yubion: SSH agent is unavailable (SSH_AUTH_SOCK is unset or invalid)" >&2
              return 1
          end

          ssh-add -s "$pkcs11_provider"
        '';
      };

      yubioff = {
        description = "Unload YubiKey PIV keys from ssh-agent";
        body = ''
          set -l pkcs11_provider ${pkgs.opensc}/lib/pkcs11/opensc-pkcs11.so

            if not set -q SSH_AUTH_SOCK; or not test -S "$SSH_AUTH_SOCK"
                echo "yubioff: SSH agent is unavailable (SSH_AUTH_SOCK is unset or invalid)" >&2
                return 1
            end

            ssh-add -e "$pkcs11_provider"
        '';
      };
    };
  };
}
