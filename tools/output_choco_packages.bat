@echo off

powershell Set-ExecutionPolicy RemoteSigned
powershell .\output_choco_packages.ps1
powershell Set-ExecutionPolicy Restricted
