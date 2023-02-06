#specify JDK here
$jdk= $Env:JAVA_HOME

Remove-Item -Recurse -Path .\package-target\*
Remove-Item -Recurse -Force -Path .\jPkg-AddLauncher-Test
& "$jdk\bin\jlink" `
	--verbose `
	--output package-target/runtime `
	--module-path "$jdk/jmods" `
	--add-modules java.base `
	--strip-native-commands `
	--no-header-files `
	--no-man-pages `
	--strip-debug `
	--compress=1

Copy-Item -Path .\target\jpackage-add-launcher-1.0-SNAPSHOT.jar -Destination .\package-target

& "$jdk\bin\jpackage" `
    --verbose `
    --type app-image `
    --runtime-image package-target/runtime `
    --module-path package-target/ `
    --input target `
    --module 'jpackage.add.launcher/org.example.App' `
    --name 'jPkg-AddLauncher-Test' `
    --app-version "1.0.0" `
    --java-options "-Djpackage-launcher.greeting=`"Hello World from the command line!`"" `
    --resource-dir .\jpkg-resources `
    --add-launcher debug=jpkg-resources\debug.properties