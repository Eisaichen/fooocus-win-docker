FROM mcr.microsoft.com/windows/server:ltsc2022

EXPOSE 7865

ENV MODEL=default
ENV ARGS=

COPY ./res C:/res
COPY ./Fooocus C:/Fooocus
COPY ./python_embeded C:/python_embeded

RUN powershell Invoke-Command "takeown /F c:\res /R /D Y /A 1> $null" ; \
    Invoke-Command "takeown /F c:\Fooocus /R /D Y 1> $null" ; \
    Invoke-Command "takeown /F c:\python_embeded /R /D Y 1> $null" ; \
    Start-Process -wait -FilePath c:\res\vc_redist.x64.exe -ArgumentList '/install /passive /norestart' ; \
    Move-Item -Force 'c:\res\nvdll\*' 'C:\Windows\System32\' ; \
    Import-Certificate -FilePath c:\res\cacert.sst -CertStoreLocation 'Cert:\LocalMachine\Root' ; \
    Move-Item -Force -Path 'c:\res\entry.bat' -Destination c:\Fooocus ; \
    rm -Recurse c:\res -Force ; \
    [Environment]::SetEnvironmentVariable('Path',"$([Environment]::GetEnvironmentVariable('Path','Machine'))"+';C:\python_embeded\Scripts;C:\python_embeded','Machine')

WORKDIR C:/Fooocus
ENTRYPOINT entry.bat
