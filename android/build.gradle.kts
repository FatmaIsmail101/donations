import java.util.Properties
import org.gradle.api.tasks.Delete

allprojects {
    repositories {
        google()
        mavenCentral()

        // ====== Nearpay Private GitLab Repository ======
        maven {
            url = uri("https://gitlab.com/api/v4/projects/37026421/packages/maven")

            credentials(HttpHeaderCredentials::class) {
                name = "Private-Token"
                value = "glpat-WssQJE374c_Vij4ZshEOIG86MQp1OmRyOXk1Cw.01.121l3ven5."
                    //"glpat-q4M9q8-KZmTYDypv7_xLiG86MQp1OmRyOXk1Cw.01.1207p7cwg"
                    //providers.gradleProperty("nearpayPosGitlabReadToken")
                    //.get()  // هيرمي استثناء لو التوكن مش موجود
            }

            authentication {
                create<HttpHeaderAuthentication>("header")
            }
        }
        // ==============================================

        maven { url = uri("https://jitpack.io") }
        maven { url = uri("https://developer.huawei.com/repo/") }
    }
}
// تغيير مجلد build
//val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
//rootProject.layout.buildDirectory.set(newBuildDir)
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
    project.evaluationDependsOn(":app")
}
//subprojects {
//    layout.buildDirectory.set(newBuildDir.dir(project.name))
//    evaluationDependsOn(":app")
//}

// تعريف task clean
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
