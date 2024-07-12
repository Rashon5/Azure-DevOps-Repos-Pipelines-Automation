# Automated Serverless Website Deployment using Azure DevOps Repos & Pipelines (CI/CD) in Multiple Environments

## Project Description
In this project, you, as a DevOps engineer, will deploy a serverless website in a fully automated way using Azure DevOps Repos and Azure Pipelines. You will create an Azure DevOps Organization that will house the Azure DevOps Repos to store the website files and the Pipelines that will automate the entire website deployment process across three different environments.

## Part 1

1. **Create Storage Accounts**
   - jwtst
   - jwqa
   - jwprd
     - Deploy 3 storage accounts - Code: 
     - Destroy 3 storage accounts - Code: 

   **Data management > Static website > Enabled**
   - Index document name: index.html
   - Copy primary endpoint below:

   - URL tst: https://jwtst.z13.web.core.windows.net/
   - URL qa: https://jwqa.z13.web.core.windows.net/
   - URL prd: https://jwprd.z13.web.core.windows.net/

2. **Azure DevOps Organization** - https://dev.azure.com/Punkery/Punkery-07
   - Create project (name whatever you want) - Punkery-01

   **Repos > Generate Git Credentials**
   - Copy credentials to Notepad++:

   **Download from GitBash (or browser):** 
   - `curl -O https://tcb-bootcamps.s3.amazonaws.com/bootcamp-microsoft-azure/en/mod7-azuredevops.zip`
   - Go into `/mod7-azuredevops/azuredevops`

   **Back to DevOps**
   - Copy 'Push an existing repository from command line' to documentation:

   ```
   git remote add origin https://Punkery@dev.azure.com/Punkery/Punkery-01/_git/Punkery-01
   git push -u origin --all
   ```

   - If `error: remote origin already exists` appears, run:
     ```
     git remote remove origin
     ```

   - Ensure `ls -ltr` returns `files/`
   - Ensure `ls -ltr` returns `images/, assets/, LICENSE.txt, index.html`

   - Cancel big Windows Visual Studio prompt
   - Cancel Git for Windows prompt
   - Paste password (it won't show), then press Enter

   **Azure DevOps > Repos > Files**
   - Files folder uploaded

## Part 2

1. **Creating Pipeline CI**
   - Enable classic editor:

   **Organization settings (bottom left)**
   - Pipelines > Settings
   - Disable both 'Disable creation of classic build pipelines' and 'Disable creation of classic release pipelines'

   - Use the classic editor to create a pipeline without YAML:

   **Azure Repo Git -> Empty job**

   - Add 'Archive files'
     - Display name: Zip files
     - Root folder or file to archive: files

   - Add 'Publish build artifacts'
     - Display name: Artifacts Publish

   - Save (Not Save & queue)

   **Triggers**
   - Enable continuous integration

   - Save

2. **Pipeline > Releases > New pipeline > Empty job**
   - Add an artifact > Build > Source: Punkery-07-CI
   - Lightning icon on Artifact, Enable Continuous deployment trigger

   - Add new Stage
     - Change Stage1 to Testing

   **Tasks**
   - Add task: Extract files
     - Archive file patterns: `**/$(Build.BuildId).zip`
     - Destination folder: `$(Build.DefaultWorkingDirectory)/$(Build.BuildId)`

   - Add task: Azure CLI
     - Display name: Upload files to Azure Blob
     - Authorizing: Azure Resource Manager connection... (Azure subscription 1)
     - Script Type: Shell
     - Script location: Inline script
     - Inline script:
       ```
       az storage blob upload-batch --account-name jwtst --destination "\$web" --source ./files --overwrite
       ```
     - Working Directory: `$(Build.DefaultWorkingDirectory)/$(Build.BuildId)`

   - Rename pipeline to Punkery-01-CD

3. **Cloning Stage**
   - Hover over Testing, then Clone, name to QA
   - Click on '2 tasks' to go to Tasks
   - Replace `--account-name` in Inline Script to `jwqa`

   **Back to Pipeline**
   - Clone QA to rename to Production, same to replace to `jwprd`

   - Click on Pre-deployment conditions icon (Checked lightning bolt/person)
     - Enable Pre-deployment approvals: Add Azure account email

## Part 3

1. **Pipelines > Pipelines**
   - Run pipeline > Run
   - Check Pipelines > Releases too
   - Click Testing to show
     - Also click on jobs

2. **In Azure: Storage accounts - jwtst, Containers, $web**
   - Go to Testing and QA environment

   - Approve Production

3. **Change index.html file**
   - Change `Congratulations!!!` to `Good Job!!!`:
     ```
     vi index.html
     git add files/index.html
     git config --global user.email "rashonzured@outlook.com"
     git commit -m "index.html change"
     ```

   ```
   [main 8d2795a] index.html change
    1 file changed, 1 insertion(+), 1 deletion(-)
   ```

   - Push changes:
     ```
     git push -u origin --all
     git pull (If needed)
     git push -u origin --all
     ```

## What I Learned
During this project, I learned how to fully automate the deployment of a serverless website using Azure DevOps. Key takeaways include:

- Setting up and configuring Azure Storage Accounts for static website hosting.
- Utilizing Azure DevOps Repos to manage code and configuration files.
- Creating CI/CD pipelines in Azure DevOps to automate the deployment process.
- Understanding the importance of environment-specific configurations and approvals in a production pipeline.
- Enhancing my skills in DevOps practices and cloud automation.

This project has significantly improved my understanding of end-to-end automation using Azure DevOps and has equipped me with practical skills in cloud deployment.
