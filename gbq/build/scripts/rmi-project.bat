@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem

@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  rmi-project startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Add default JVM options here. You can also use JAVA_OPTS and RMI_PROJECT_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto init

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto init

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:init
@rem Get command-line arguments, handling Windows variants

if not "%OS%" == "Windows_NT" goto win9xME_args

:win9xME_args
@rem Slurp the command line arguments.
set CMD_LINE_ARGS=
set _SKIP=2

:win9xME_args_slurp
if "x%~1" == "x" goto execute

set CMD_LINE_ARGS=%*

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\rmi-project.jar;%APP_HOME%\lib\winium-webdriver-0.1.0-1.jar;%APP_HOME%\lib\selenium-java-3.141.59.jar;%APP_HOME%\lib\cucumber-picocontainer-1.2.4.jar;%APP_HOME%\lib\cucumber-java-1.2.4.jar;%APP_HOME%\lib\cucumber-junit-1.2.4.jar;%APP_HOME%\lib\cucumber-core-1.2.4.jar;%APP_HOME%\lib\cucumber-jvm-deps-1.0.5.jar;%APP_HOME%\lib\gherkin-2.12.2.jar;%APP_HOME%\lib\javax.ws.rs-api-2.1.jar;%APP_HOME%\lib\jersey-media-json-processing-2.26.jar;%APP_HOME%\lib\jersey-media-multipart-2.27.jar;%APP_HOME%\lib\slf4j-api-1.7.25.jar;%APP_HOME%\lib\log4j-1.2.17.jar;%APP_HOME%\lib\jersey-media-json-jackson-2.28.jar;%APP_HOME%\lib\aws-java-sdk-s3-1.11.762.jar;%APP_HOME%\lib\aws-java-sdk-kms-1.11.762.jar;%APP_HOME%\lib\aws-java-sdk-core-1.11.762.jar;%APP_HOME%\lib\jackson-module-jaxb-annotations-2.9.8.jar;%APP_HOME%\lib\jmespath-java-1.11.762.jar;%APP_HOME%\lib\jackson-databind-2.9.8.jar;%APP_HOME%\lib\jackson-dataformat-cbor-2.6.7.jar;%APP_HOME%\lib\jackson-core-2.9.8.jar;%APP_HOME%\lib\jersey-client-2.28.jar;%APP_HOME%\lib\jersey-hk2-2.28.jar;%APP_HOME%\lib\activation-1.1.jar;%APP_HOME%\lib\json-simple-1.1.jar;%APP_HOME%\lib\jooq-3.13.1.jar;%APP_HOME%\lib\selenium-chrome-driver-3.141.59.jar;%APP_HOME%\lib\selenium-edge-driver-3.141.59.jar;%APP_HOME%\lib\selenium-firefox-driver-3.141.59.jar;%APP_HOME%\lib\selenium-ie-driver-3.141.59.jar;%APP_HOME%\lib\selenium-opera-driver-3.141.59.jar;%APP_HOME%\lib\selenium-safari-driver-3.141.59.jar;%APP_HOME%\lib\selenium-support-3.141.59.jar;%APP_HOME%\lib\selenium-remote-driver-3.141.59.jar;%APP_HOME%\lib\selenium-api-3.141.59.jar;%APP_HOME%\lib\byte-buddy-1.8.15.jar;%APP_HOME%\lib\commons-exec-1.3.jar;%APP_HOME%\lib\guava-25.0-jre.jar;%APP_HOME%\lib\okhttp-3.11.0.jar;%APP_HOME%\lib\okio-1.14.0.jar;%APP_HOME%\lib\cucumber-html-0.2.3.jar;%APP_HOME%\lib\junit-4.11.jar;%APP_HOME%\lib\picocontainer-2.15.jar;%APP_HOME%\lib\jersey-common-2.28.jar;%APP_HOME%\lib\javax.json-1.1.jar;%APP_HOME%\lib\jsonp-jaxrs-1.1.1.jar;%APP_HOME%\lib\mimepull-1.9.6.jar;%APP_HOME%\lib\jackson-annotations-2.9.8.jar;%APP_HOME%\lib\jersey-entity-filtering-2.28.jar;%APP_HOME%\lib\jakarta.ws.rs-api-2.1.5.jar;%APP_HOME%\lib\hk2-locator-2.5.0.jar;%APP_HOME%\lib\hk2-api-2.5.0.jar;%APP_HOME%\lib\hk2-utils-2.5.0.jar;%APP_HOME%\lib\jakarta.inject-2.5.0.jar;%APP_HOME%\lib\httpclient-4.5.9.jar;%APP_HOME%\lib\commons-logging-1.2.jar;%APP_HOME%\lib\ion-java-1.0.2.jar;%APP_HOME%\lib\joda-time-2.8.1.jar;%APP_HOME%\lib\reactive-streams-1.0.2.jar;%APP_HOME%\lib\jaxb-api-2.3.1.jar;%APP_HOME%\lib\jsr305-1.3.9.jar;%APP_HOME%\lib\checker-compat-qual-2.0.0.jar;%APP_HOME%\lib\error_prone_annotations-2.1.3.jar;%APP_HOME%\lib\j2objc-annotations-1.1.jar;%APP_HOME%\lib\animal-sniffer-annotations-1.14.jar;%APP_HOME%\lib\hamcrest-core-1.3.jar;%APP_HOME%\lib\jakarta.annotation-api-1.3.4.jar;%APP_HOME%\lib\osgi-resource-locator-1.0.1.jar;%APP_HOME%\lib\aopalliance-repackaged-2.5.0.jar;%APP_HOME%\lib\javassist-3.22.0-CR2.jar;%APP_HOME%\lib\httpcore-4.4.11.jar;%APP_HOME%\lib\commons-codec-1.11.jar;%APP_HOME%\lib\javax.activation-api-1.2.0.jar

@rem Execute rmi-project
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %RMI_PROJECT_OPTS%  -classpath "%CLASSPATH%" common.s3.S3DataUploader %CMD_LINE_ARGS%

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable RMI_PROJECT_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%RMI_PROJECT_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
