allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.buildDir = File("${rootProject.buildDir}/${project.name}")
    project.evaluationDependsOn(":app")

    afterEvaluate {
        if (project.plugins.hasPlugin("com.android.library")) {
            val androidExt = project.extensions.findByName("android")
            if (androidExt != null) {
                try {
                    val currentNamespace = androidExt.javaClass.getMethod("getNamespace").invoke(androidExt)
                    if (currentNamespace == null) {
                        androidExt.javaClass.getMethod("setNamespace", String::class.java).invoke(androidExt, project.group.toString())
                    }
                } catch (e: Exception) {
                }
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

subprojects {
    pluginManager.withPlugin("com.android.library") {
        extensions.configure<com.android.build.gradle.LibraryExtension>("android") {
            if (namespace == null) {
                namespace = group.toString()
            }
        }
    }
}

