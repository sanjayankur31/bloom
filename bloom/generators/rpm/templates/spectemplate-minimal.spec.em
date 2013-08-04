%global module_name @(Package)

Name:           ros-groovy-%{module_name}
Version:        @(Version)
Release:        1%{?dist}
Summary:        @(Description)

License:        @(' and  '.join(License))
URL:            @(Homepage)
Source0:        

BuildRequires:  @(' '.join(BuildDepends))
Requires:       @(' '.join(Depends))

%description
%{Summary}


%prep
%setup -q


%build


%install


%clean


%files
%doc



%changelog
# Need to replace it with today's date
* Sun Aug 04 2013 Ankur Sinha <ankursinha AT fedoraproject DOT org> - @(Version) -1
- Initial rpm build

