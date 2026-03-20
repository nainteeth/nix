{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
  };
}

# ollama pull qwen2.5-coder:14b
