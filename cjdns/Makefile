# You may redistribute this program and/or modify it under the terms of
# the GNU General Public License as published by the Free Software Foundation,
# either version 3 of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
include $(TOPDIR)/rules.mk

PKG_NAME:=cjdns
#PKG_VERSION:=master
PKG_VERSION:=crashey_04f4b755f110b4fee04fe9a0a0cdd857a1c56e09

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=git://github.com/cjdelisle/cjdns.git
PKG_SOURCE_PROTO:=git
#PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE_VERSION:=04f4b755f110b4fee04fe9a0a0cdd857a1c56e09
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/cjdns
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Routing and Redirection
  TITLE:=Experimental self configuring routing protocol.
  DEPENDS:=+kmod-tun +kmod-ipv6 +libnl-tiny +libpthread +librt +SSP_SUPPORT:libssp
  MAINTAINER:=cjd -- #cjdns on irc.efnet.org
endef

define Package/cjdns/config
	config CJDNS_INIT_PROCD
	bool "Build with procd init script"
	help
		Cjdns doesn`t start at reboot with installed procd and oldstyle init script.
	default n
endef

define Build/Configure
endef

define Build/Compile
	CROSS="true" \
	CFLAGS="$(TARGET_CFLAGS)" \
	CC="$(TARGET_CC)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	TARGET_ARCH="$(CONFIG_ARCH)" \
	SSP_SUPPORT="$(CONFIG_SSP_SUPPORT)" \
	UCLIBC=1 \
	Seccomp_NO=1 \
	$(PKG_BUILD_DIR)/do
endef

define Package/cjdns/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/cjdroute   $(1)/usr/sbin/cjdroute
	$(INSTALL_DIR) $(1)/etc/init.d
	if [ "$CONFIG_CJDNS_INIT_PROCD" == "y" ]
		$(INSTALL_BIN) ./files/cjdns_init-procd 	$(1)/etc/init.d/cjdns
	else
		$(INSTALL_BIN) ./files/cjdns_init-oldstyle 	$(1)/etc/init.d/cjdns		
	fi
endef

$(eval $(call BuildPackage,cjdns))
