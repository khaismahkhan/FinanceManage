//
//  ProfileScreen.swift
//  TheProject
//
//

import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel // Shared profile data
    
    @State private var isEditing: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                    .accessibilityLabel("Profile picture")
                    .accessibilityHint("This is your profile picture.")
                
                if isEditing {
                    EditProfileView()
                        .accessibilityLabel("Edit Profile Fields")
                        .accessibilityHint("Edit your name, email, and phone number.")
                } else {
                    ProfileDetailView(profile: profileViewModel.profile)
                        .accessibilityLabel("Profile Details")
                        .accessibilityHint("Displays your name, email, and phone number.")
                }
                
                Button(action: {
                    isEditing.toggle()
                }) {
                    Text(isEditing ? "Save" : "Edit Profile")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isEditing ? Color.green : Color.blue)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .accessibilityLabel(isEditing ? "Save Profile" : "Edit Profile")
                .accessibilityHint(isEditing ? "Save the changes made to your profile" : "Enter edit mode to update your profile")
                
                Spacer()
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileDetailView: View {
    let profile: Profile
    
    var body: some View {
        VStack(spacing: 16) {
            ProfileRow(title: "Name", value: profile.name)
                .accessibilityLabel("Name: \(profile.name)")
            ProfileRow(title: "Email", value: profile.email)
                .accessibilityLabel("Email: \(profile.email)")
            ProfileRow(title: "Phone", value: profile.phone)
                .accessibilityLabel("Phone: \(profile.phone)")
        }
        .padding(.horizontal)
    }
}

struct EditProfileView: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            // Editable TextFields
            TextField("Name", text: $profileViewModel.profile.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accessibilityLabel("Name field")
                .accessibilityHint("Edit your name here")
            
            TextField("Email", text: $profileViewModel.profile.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .accessibilityLabel("Email field")
                .accessibilityHint("Edit your email address here")
            
            TextField("Phone", text: $profileViewModel.profile.phone)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.phonePad)
                .accessibilityLabel("Phone field")
                .accessibilityHint("Edit your phone number here")
        }
        .padding(.horizontal)
    }
}

struct ProfileRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(value)")
    }
}

#Preview {
    ProfileScreen()
        .environmentObject(ProfileViewModel()) 
}
