plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") version "4.4.1" // Added version as required
}

android {
    namespace = "com.example.deusmagnus"
    compileSdk = 35 // Updated to 35 as recommended for video_player_android plugin

    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.deusmagnus.deusmagnus"
        minSdk = 23
        targetSdk = 35 // Match compileSdk for best compatibility
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
    // Import the Firebase BoM (Bill of Materials)
    implementation(platform("com.google.firebase:firebase-bom:34.3.0"))

    // Firebase Analytics
    implementation("com.google.firebase:firebase-analytics")

    // Uncomment and add other Firebase dependencies if needed:
    // implementation("com.google.firebase:firebase-auth")
    // implementation("com.google.firebase:firebase-firestore")
}

