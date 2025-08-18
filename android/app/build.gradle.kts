plugins {
    id("com.android.application")
    id("com.google.gms.google-services") // FlutterFire config
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.gitnote"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.gitnote"
        minSdk = 23
        targetSdk = 35
        versionCode = 1
        versionName = "1.0.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase BoM (ensures all Firebase libs use compatible versions)
    implementation(platform("com.google.firebase:firebase-bom:33.1.2"))

    // Firebase Auth
    implementation("com.google.firebase:firebase-auth")

    // Google Play Services Auth (needed for Google Sign-In)
    implementation("com.google.android.gms:play-services-auth:21.2.0")
}
