# nix flake init -t "github:niksingh710/ndots#<template-name>
{
  dissertation.path = ./dissertation;
  flake-parts.path = ./flake-parts;
  python-venv.path = ./python-venv;
  rust.path = ./rust;
}
