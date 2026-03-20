function fn() {
    var uuid = java.util.UUID.randomUUID().toString();
    // Generate a unique email address using a prefix and part of a UUID
    return {
        email: "qa_test_" + uuid.substring(0, 8) + "@challenge.com",
        name: "Automation User " + uuid.substring(0, 5)
    };
}