{ config, lib, pkgs, ... }:

{
environment.systemPackages = [
  (pkgs.anki.withAddons [
    pkgs.ankiAddons.review-heatmap
  ])
];
}
