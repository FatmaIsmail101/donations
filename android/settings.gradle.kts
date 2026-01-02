//import org.gradle.api.credentials.HttpHeaderCredentials
//import org.gradle.authentication.http.HttpHeaderAuthentication
//
//pluginManagement {
//    repositories {
//        google()
//        mavenCentral()
//        gradlePluginPortal()
//    }
//    plugins {
//        id("dev.flutter.flutter-plugin-loader") version "1.0.0"
//        // id("com.android.application") version "8.12.0" apply false
//        //id("org.jetbrains.kotlin.android") version "1.9.24" apply false
//        id("org.jetbrains.kotlin.android") version "2.1.0" apply false
//        id("com.android.library") version "8.2.2" apply false
//
//        id("com.android.application") version "8.2.2" apply false
//        //id("org.jetbrains.kotlin.android") version "2.1.0" apply false
//    }
//    val flutterSdkPath =
//        run {
//            val properties = java.util.Properties()
//            file("local.properties").inputStream().use { properties.load(it) }
//            val flutterSdkPath = properties.getProperty("flutter.sdk")
//            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
//            flutterSdkPath
//        }
//
//    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")
//
//}
//dependencyResolutionManagement {
//    repositories {
//        google()
//        mavenCentral()
//        maven(url = "https://developer.huawei.com/repo/")
//        maven {
//            url = uri("https://gitlab.com/api/v4/projects/37026421/packages/maven")
//            credentials(HttpHeaderCredentials::class) {
//                name = "Private-Token"
//                value = "glpat-q4M9q8-KZmTYDypv7_xLiG86MQp1OmRyOXk1Cw.01.1207p7cwg" //will be supported from Nearpay Product Team
//            }
//            authentication {
//                create<HttpHeaderAuthentication>("header")
//            }
//        }
//    }
//}
//
//
//
//include(":app")
//include(":flutter_terminal_sdk")
//project(":flutter_terminal_sdk").projectDir = file("D:/easacc/flutter-terminal-sdk")

//import java.util.Properties
//import org.gradle.api.credentials.HttpHeaderCredentials
//import org.gradle.authentication.http.HttpHeaderAuthentication




pluginManagement {
    val flutterSdkPath =
        run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
//            properties.getProperty("flutter.sdk")
//            ?: error("flutter.sdk not set in local.properties")
//
    }
    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}


//includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

//dependencyResolutionManagement {
//    repositories {
//        google()
//        mavenCentral()
//        maven(url = "https://developer.huawei.com/repo/")
//        maven {
//            url = uri("https://gitlab.com/api/v4/projects/37026421/packages/maven")
//            credentials(HttpHeaderCredentials::class) {
//                name = "Private-Token"
//                value = "glpat-q4M9q8-KZmTYDypv7_xLiG86MQp1OmRyOXk1Cw.01.1207p7cwg"
//            }
//            authentication {
//                create<HttpHeaderAuthentication>("header")
//            }
//        }
//    }
//}
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("org.jetbrains.kotlin.android") version "2.2.20" apply false
    id("com.android.library") version "8.11.1" apply false
    //id("com.android.application") version "8.2.2" apply false
}

include(":app")
//include(":flutter_terminal_sdk")
//project(":flutter_terminal_sdk").projectDir = file("D:/easacc/flutter-terminal-sdk")
