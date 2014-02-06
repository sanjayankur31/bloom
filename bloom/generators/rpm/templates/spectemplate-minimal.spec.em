%global module_name @(Package)
%{?scl:%scl_package @(Package)}
%{!?scl:%global pkg_name %{name}}

# Python globals
%global pybasever 2.7
%global pylibdir %{_libdir}/python%{pybasever}
%global scl_python_sitearch %{pylibdir}/site-packages
%global scl_python_sitelib %{_prefix}/lib/python%{pybasever}/site-packages


Name:           %{?scl_prefix}%{module_name}
Version:        @(Version)
Release:        1%{?dist}
Summary:        ROS @(RosVersion) %{module_name} module
#BuildArch:      noarch

License:        @(' and  '.join(License))
URL:            @(Homepage)

# wget --content-disposition https://github.com/ros/@(Package)/archive/@(Version).tar.gz
Source0:        %{module_name}-%{version}.tar.gz

# BuildRequires
BuildRequires:       @('BuildRequires:       '.join(BuildDepends))


# Requires
Requires:        @('Requires:        '.join(Depends))

%{?scl:Requires: %scl_runtime}

%description
@('\n'.join(Description))

# In case it's needed
#%package devel
#Summary: Development files for %{name}
#Requires:  %{?scl_prefix}%{module_name} = %{version}-%{release}

#%description devel
#Development files for %{module_name}


%prep
%setup -q -n %{module_name}-%{version}


%build

# Remove the scl enabling if it isn't required. Generally required to build packages on top of catkin
# They're all conditionals and will not be run if scl isn't defined.
%{?scl:scl -l}

%{?scl:scl enable %{scl} - << \EOF}
python -c 'import sys; print sys.path'

mkdir build
pushd build
    %cmake  .. -DCATKIN_BUILD_BINARY_PACKAGE="1" -DSETUPTOOLS_DEB_LAYOUT=OFF
    make %{?_smp_mflags}
popd
pushd doc
#   export PYTHONPATH=$(pwd)/src/genmsg
    make html man
popd
%{?scl:EOF}

%install
%{?scl:scl -l}
%{?scl:scl enable %{scl} "}
make -C build install DESTDIR=$RPM_BUILD_ROOT
%{?scl:"}

# Move packageconfig to correct location
#mkdir -p $RPM_BUILD_ROOT%{_datadir}/pkgconfig
#mv -v $RPM_BUILD_ROOT/%{?_scl_root}/%{_usr}/lib/pkgconfig/%{module_name}.pc $RPM_BUILD_ROOT/%{_datadir}/pkgconfig

%check 
#%{?scl:scl -l}
#%{?scl:scl enable %{scl} "}
#%{?scl:export PYTHONPATH=$PYTHONPATH:%{?scl_python_sitelib}:%{?scl_python_sitearch}}

# OR ANOTHER COMMAND
#python setup.py test 
#%{?scl:"}

%files
%doc

# In case it's needed
#%files devel


%changelog
# Need to replace it with today's date
* Sun Aug 04 2013 Ankur Sinha <ankursinha AT fedoraproject DOT org> - @(Version) -1
- Initial rpm build

