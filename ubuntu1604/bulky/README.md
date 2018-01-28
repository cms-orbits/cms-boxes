# All-in-one VM (Bulky)

TODO: services, ports and urls?

TODO: credentials, what, why, whom?

TODO: Service diagram


## Details you should know

- The all in one configuration goes against the CMS-dev recommendations, mostly mixing Core services, workers and database hosts together. I opted to use this distribution for convenience and reverse engineering purposes (hack around :octocat:).
- The cmsuser (database user) default password is hardcoded right now (`unsecure`) but overridable.
- There is a `phppgadmin` installed in this box if you need to check CMS data, you can find it using the URL `http://[Vagrant Box IP]/phppgadmin`
- After provisioning the CMS environment there should be:
  - All the CMS services up and running.
  - An administrative user with username and password `admin`.
  - A test contest called `con_test`.
  - All the task declared in this repository [cms-dev/con_test](https://github.com/cms-dev/con_test)
  - Three test users with username `u` followed by its number, and password using the same pattern but using the letter `p` instead. For example the first user credentials are `u1:p1`
