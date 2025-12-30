import java.util.Properties
import org.gradle.api.tasks.Delete


// تغيير مجلد build
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    layout.buildDirectory.set(newBuildDir.dir(project.name))
    evaluationDependsOn(":app")
}

// تعريف task clean
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
