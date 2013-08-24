%global module_name @(Package)

Name:           ros-@(RosVersion)-%{module_name}
Version:        @(Version)
Release:        1%{?dist}
Summary:        ROS @(RosVersion) %{module_name} module.

License:        @(' and  '.join(License))
URL:            @(Homepage)
Source0:        

# All catkinized packages require catkin
BuildRequires:  @(' '.join(BuildDepends))
Requires:       @(' '.join(Depends))

Provides:       ros-@(RosVersion)-%{module_name}

%description
@('\n'.join(Description))



%prep
%setup -q


%build
%cmake 
make %{?_smp_mflags}

%install
make install DESTDIR=$RPM_BUILD_ROOT


%clean


%files
%doc



%changelog
# Need to replace it with today's date
* Sun Aug 04 2013 Ankur Sinha <ankursinha AT fedoraproject DOT org> - @(Version) -1
- Initial rpm build

