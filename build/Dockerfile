FROM mcr.microsoft.com/windows/server:ltsc2022

EXPOSE 7865

ENV MODEL=default
ENV ARGS=

COPY ./res C:/res
COPY ./Fooocus C:/Fooocus
COPY ./python_embeded C:/python_embeded

RUN powershell Start-Process -wait -FilePath c:\res\vc_redist.x64.exe -ArgumentList '/install /passive /norestart' ; \
    Move-Item -Path c:\res\nvdll\System32\* -Destination C:\Windows\System32 ; \
    Move-Item -Path c:\res\nvdll\SysWOW64\* -Destination C:\Windows\SysWOW64 ; \
    Move-Item -Force -Path 'c:\res\entry.bat' -Destination c:\Fooocus ; \
    rm -Recurse c:\res -Force ; \
    [Environment]::SetEnvironmentVariable('Path',"$([Environment]::GetEnvironmentVariable('Path','Machine'))"+';C:\python_embeded\Scripts;C:\python_embeded','Machine')

WORKDIR C:/Fooocus
ENTRYPOINT entry.bat
