package com.tdtu.recruitmentservice.firebase;

import java.io.FileInputStream;
import java.io.IOException;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Service;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;

@Service
public class FirebaseInitialization {

	@PostConstruct
	public void initialization() {
		String firebaseConfigPath = System.getenv("FIREBASE_CONFIG_PATH");
	    if (firebaseConfigPath == null) {
	        throw new IllegalArgumentException("FIREBASE_CONFIG_PATH environment variable not set");
	    }

	    try (FileInputStream serviceAccount = new FileInputStream(firebaseConfigPath)) {
	        FirebaseOptions options = new FirebaseOptions.Builder()
	                .setCredentials(GoogleCredentials.fromStream(serviceAccount))
	                .build();

	        FirebaseApp.initializeApp(options);
	        System.out.println("FirebaseApp initialized successfully");
	    } catch (IOException e) {
	        System.err.println("Failed to initialize Firebase: " + e.getMessage());
	        e.printStackTrace();
	    }
	}
}
