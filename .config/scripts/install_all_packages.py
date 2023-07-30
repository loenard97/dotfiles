#!/bin/python

import os
import pathlib
import subprocess


def is_package(line: str) -> bool:
    if line.startswith("#") or not len(line):
        return False
    return True


def main():
    """Install all packages listed in ~/.config/packages"""
    for (root, _, files) in os.walk("/home/dennis/.config/packages"):

        for file in files:
            file_path = pathlib.Path(root, file)
            print(f"\nInstalling {file.upper()} packages...")

            with open(file_path, "r") as file_handle:
                packages = file_handle.read().split("\n")
                packages = list(filter(is_package, packages))
                print(packages)

                if file.endswith("_aur"):
                    print("install from aur")
                    for package in packages:
                        subprocess.run(["git", "clone", f"https://aur.archlinux.org/{package}.git", f"/home/dennis/Downloads/AUR/{package}"])
                else:
                    subprocess.run(["sudo", "pacman", "-S", "--needed", *packages])


if __name__ == "__main__":
    main()

