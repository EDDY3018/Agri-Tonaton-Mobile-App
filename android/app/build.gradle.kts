plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}
// Read Flutter version props from local.properties (or use defaults)
val flutterVersionCode: Int = project.findProperty("flutter.versionCode")
    ?.toString()?.toInt() ?: 1
val flutterVersionName: String = project.findProperty("flutter.versionName")
    ?.toString() ?: "1.0"

android {
    namespace = "com.tufftec.agri_tonaton"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.tufftec.agri_tonaton"
        minSdk = 24
        targetSdk = 35
        versionCode = flutterVersionCode
        versionName = flutterVersionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.google.android.gms:play-services-auth:20.7.0")
}


flutter {
    source = "../.."
}
dependencies {
    implementation("com.google.android.gms:play-services-auth:20.7.0")
}
