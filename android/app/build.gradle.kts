// App-level build.gradle.kts

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android") // Kotlin plugin
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // Firebase Google Services plugin
}

android {
    namespace = "com.example.deusmagnus" // Must match your package
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.deusmagnus.deusmagnus" // Must match Firebase console
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

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase BoM (Bill of Materials)
    implementation(platform("com.google.firebase:firebase-bom:34.3.0"))

    // Firebase dependencies (no version, BoM manages versions)
    implementation("com.google.firebase:firebase-analytics-ktx")
    implementation("com.google.firebase:firebase-auth-ktx")
    implementation("com.google.firebase:firebase-firestore-ktx")
}
