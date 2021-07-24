CURRENT_DIR = $(notdir $(shell pwd))
STACK_NAME  = dzansch

pac_check:
ifndef GITHUB_REPO_PAC
	$(error GITHUB_REPO_PAC is undefined)
endif

ifndef GITHUB_ORG
	$(error GITHUB_ORG is undefined)
endif

ifndef DOMAIN
	$(error DOMAIN is undefined)
endif

ifndef DEPLOY_BRANCH
	$(error DEPLOY_BRANCH is undefined)
endif

create: pac_check
	aws cloudformation deploy \
		--template-file ./amplify-template.yml \
		--capabilities CAPABILITY_IAM \
		--parameter-overrides \
			OauthToken=$(GITHUB_REPO_PAC) \
			Repository=$(GITHUB_ORG)/$(CURRENT_DIR) \
			Domain=$(DOMAIN) \
			Branch=$(DEPLOY_BRANCH) \
		--stack-name $(STACK_NAME)

# ${PWD##*/}