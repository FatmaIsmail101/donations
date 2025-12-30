
pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
        maven(url = "https://developer.huawei.com/repo/")
        maven {
            url = uri("https://gitlab.com/api/v4/projects/37026421/packages/maven")
            credentials(HttpHeaderCredentials::class) {
                name = "Private-Token"
                value = "glpat-q4M9q8-KZmTYDypv7_xLiG86MQp1OmRyOXk1Cw.01.1207p7cwg" //will be supported from Nearpay Product Team
            }
            authentication {
                create<HttpHeaderAuthentication>("header")
            }
        }
    }
}


plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.9.1" apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
}

include(":app")
include(":flutter_terminal_sdk")
project(":flutter_terminal_sdk").projectDir = file("D:/easacc/flutter-terminal-sdk")
