<script>
import { mapGetters } from 'vuex';
import { MANAGEMENT } from '@shell/config/types';
import { SETTING } from '@shell/config/settings';

export default {
  props: {
    fileName: {
      type:     String,
      required: true
    },
    dark: {
      type:    Boolean,
      default: false
    }
  },
  data() {
    const managementSettings = this.$store.getters['management/all'](MANAGEMENT.SETTING);

    const uiLoginBackgroundLight = managementSettings?.filter((setting) => setting.id === SETTING.LOGIN_BACKGROUND_LIGHT)?.[0]?.value;
    const uiLoginBackgroundDark = managementSettings?.filter((setting) => setting.id === SETTING.LOGIN_BACKGROUND_DARK)?.[0]?.value;

    return {
      managementSettings,

      /**
       * Login settings fields don't require reactivity; the correct value for those fields is the initial one.
       * This will avoid side effects after the management store is reset when landing on login page.
       */
      uiLoginBackgroundLight,
      uiLoginBackgroundDark,
    };
  },
  computed: {
    ...mapGetters({ theme: 'prefs/theme' }),

    brand() {
      const setting = this.managementSettings.filter((setting) => setting.id === SETTING.BRAND)[0] || {};

      return setting.value;
    },

    uiLogoLight() {
      const setting = this.managementSettings.filter((setting) => setting.id === SETTING.LOGO_LIGHT)[0] || {};

      return setting.value;
    },

    uiLogoDark() {
      const setting = this.managementSettings.filter((setting) => setting.id === SETTING.LOGO_DARK)[0] || {};

      return setting.value;
    },

    uiBannerLight() {
      const setting = this.managementSettings.filter((setting) => setting.id === SETTING.BANNER_LIGHT)[0] || {};

      return setting.value;
    },

    uiBannerDark() {
      const setting = this.managementSettings.filter((setting) => setting.id === SETTING.BANNER_DARK)[0] || {};

      return setting.value;
    },

    defaultPathToBrandedImage() {
      const themePrefix = this.theme === 'dark' ? 'dark/' : '';

      try {
        return require(`~shell/assets/images/pl/${ themePrefix }${ this.fileName }`);
      } catch {
        return require(`~shell/assets/images/pl/${ this.fileName }`);
      }
    },

    pathToBrandedImage() {
        const logo = "data:image/png;base64,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";

        const banner = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTMzMyIgaGVpZ2h0PSIyMDAiIHZpZXdCb3g9IjAgMCAxMzMzIDIwMCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPGcgY2xpcC1wYXRoPSJ1cmwoI2NsaXAwXzM0XzM0NikiPgo8cmVjdCB3aWR0aD0iMTMzMyIgaGVpZ2h0PSIyMDAiIGZpbGw9ImJsYWNrIi8+CjxnIG9wYWNpdHk9IjAuMyI+CjxwYXRoIGQ9Ik0xMDIzLjAxIDU2NS4xMzdIOTE2LjgzNUM0MjkuNjA2IDU2NS4xMzcgNzQyLjYyOCAxMDkuMzkxIDI1NS4zOTkgMTA5LjM5MVYxMDkuNjQySC0xNDkiIHN0cm9rZT0iIzBDRTJGMiIgc3Ryb2tlLXdpZHRoPSIwLjY1NzA3MyIvPgo8cGF0aCBkPSJNMTAzMC4xMSA1NTcuMjUySDkyMy45OTZDNDM3LjAzNiA1NTcuMjUyIDc0OS44ODYgMTAxLjUwNiAyNjIuOTI1IDEwMS41MDZWMTAxLjc1N0gtMTQxLjI1MSIgc3Ryb2tlPSIjMENFMkYyIiBzdHJva2Utd2lkdGg9IjAuNjU3MDczIi8+CjxwYXRoIGQ9Ik0xMDM3Ljg2IDU0OS4zNjdIOTMxLjYyOEM0NDQuMTMxIDU0OS4zNjcgNzU3LjMyNiA5My42MjEzIDI2OS44MjggOTMuNjIxM1Y5My44NzJILTEzNC43OTQiIHN0cm9rZT0iIzBDRTJGMiIgc3Ryb2tlLXdpZHRoPSIwLjY1NzA3MyIvPgo8cGF0aCBkPSJNMTA0NC4zMiA1NDEuNDgySDkzOC4yNjFDNDUxLjU2OSA1NDEuNDgyIDc2NC4yNDcgODQuOTQ4IDI3Ny41NTQgODQuOTQ4Vjg1LjE5OTFILTEyNi4zOTkiIHN0cm9rZT0iIzBDRTJGMiIgc3Ryb2tlLXdpZHRoPSIwLjY1NzA3MyIvPgo8cGF0aCBkPSJNMTA1Mi43MSA1MzIuODA5SDk0Ni40OEM0NTguOTgzIDUzMi44MDkgNzcyLjE3OCA3Ny4wNjMgMjg0LjY4IDc3LjA2M1Y3Ny4zMTM3SC0xMTkuOTQyIiBzdHJva2U9IiMwQ0UyRjIiIHN0cm9rZS13aWR0aD0iMC42NTcwNzMiLz4KPHBhdGggZD0iTTEwNTkuMTcgNTI0LjkyNEg5NTMuMDU0QzQ2Ni4wOTQgNTI0LjkyNCA3NzguOTQ0IDY5LjE3ODMgMjkxLjk4MyA2OS4xNzgzVjY5LjQyOUgtMTEyLjE5MyIgc3Ryb2tlPSIjMENFMkYyIiBzdHJva2Utd2lkdGg9IjAuNjU3MDczIi8+CjxwYXRoIG9wYWNpdHk9IjAuOTUiIGQ9Ik0xMDY2LjkyIDUxNy4wMzlIOTYwLjY4NkM0NzMuMTg5IDUxNy4wMzkgNzg2LjM4NCA2MS4yOTMzIDI5OC44ODYgNjEuMjkzM1Y2MS41NDRILTEwNS43MzYiIHN0cm9rZT0iIzBDRTJGMiIgc3Ryb2tlLXdpZHRoPSIwLjY1NzA3MyIvPgo8cGF0aCBvcGFjaXR5PSIwLjkiIGQ9Ik0xMDczLjM3IDUwOS4xNTRIOTY3LjMxOUM0ODAuNjI3IDUwOS4xNTQgNzkzLjMwNCA1My40MDg1IDMwNi42MTIgNTMuNDA4NVY1My42NTkySC05Ny4zNDEzIiBzdHJva2U9IiMwQ0UyRjIiIHN0cm9rZS13aWR0aD0iMC42NTcwNzMiLz4KPHBhdGggb3BhY2l0eT0iMC44NSIgZD0iTTEwODEuNzcgNTAxLjI2OUg5NzUuNTM4QzQ4OC4wNCA1MDEuMjY5IDgwMS4yMzUgNDUuNTIzNiAzMTMuNzM4IDQ1LjUyMzZWNDUuNzc0M0gtOTAuODg0IiBzdHJva2U9IiMwQ0UyRjIiIHN0cm9rZS13aWR0aD0iMC42NTcwNzMiLz4KPHBhdGggb3BhY2l0eT0iMC44IiBkPSJNMTA4OC44NyA0OTMuMzg1SDk4Mi43QzQ5NS40NzEgNDkzLjM4NSA4MDguNDkzIDM2Ljg1MDIgMzIxLjI2NCAzNi44NTAyVjM3LjEwMTNILTgzLjEzNTIiIHN0cm9rZT0iIzBDRTJGMiIgc3Ryb2tlLXdpZHRoPSIwLjY1NzA3MyIvPgo8cGF0aCBvcGFjaXR5PSIwLjc1IiBkPSJNMTA5NS45NyA0ODQuNzExSDk4OS44MDNDNTAyLjU3NCA0ODQuNzExIDgxNS41OTYgMjguOTY1MyAzMjguMzY3IDI4Ljk2NTNWMjkuMjE2SC03Ni4wMzIyIiBzdHJva2U9IiMwQ0UyRjIiIHN0cm9rZS13aWR0aD0iMC42NTcwNzMiLz4KPHBhdGggb3BhY2l0eT0iMC43IiBkPSJNMTEwMy4wOCA0NzYuODI2SDk5Ni45MDZDNTA5LjY3NyA0NzYuODI2IDgyMi42OTkgMjEuMDgwNCAzMzUuNDcgMjEuMDgwNFYyMS4zMzEySC02OC45MjkxIiBzdHJva2U9IiMwQ0UyRjIiIHN0cm9rZS13aWR0aD0iMC42NTcwNzMiLz4KPHBhdGggb3BhY2l0eT0iMC42NSIgZD0iTTExMTAuMTggNDY4Ljk0MUgxMDA0LjA3QzUxNy4xMDcgNDY4Ljk0MSA4MjkuOTU3IDEzLjE5NTYgMzQyLjk5NiAxMy4xOTU2VjEzLjQ0NjNILTYxLjE4MDIiIHN0cm9rZT0iIzBDRTJGMiIgc3Ryb2tlLXdpZHRoPSIwLjY1NzA3MyIvPgo8cGF0aCBvcGFjaXR5PSIwLjYiIGQ9Ik0xMTE3LjkzIDQ2MS4wNTdIMTAxMS43NkM1MjQuNTI5IDQ2MS4wNTcgODM3LjU1MSA1LjMxMDY0IDM1MC4zMjIgNS4zMTA2NFY1LjU2MTM1SC01NC4wNzczIiBzdHJva2U9IiMwQ0UyRjIiIHN0cm9rZS13aWR0aD0iMC42NTcwNzMiLz4KPHBhdGggb3BhY2l0eT0iMC41NSIgZD0iTTExMjUuMDMgNDUzLjE3MkgxMDE4Ljg2QzUzMS42MzIgNDUzLjE3MiA4NDQuNjU0IC0yLjU3NDIzIDM1Ny40MjUgLTIuNTc0MjNWLTIuMzIzNTJILTQ2Ljk3NCIgc3Ryb2tlPSIjMENFMkYyIiBzdHJva2Utd2lkdGg9IjAuNjU3MDczIi8+CjxwYXRoIG9wYWNpdHk9IjAuNSIgZD0iTTExMzIuMTQgNDQ1LjI4N0gxMDI1Ljk2QzUzOC43MzUgNDQ1LjI4NyA4NTEuNzU3IC0xMS4yNDc1IDM2NC41MjggLTExLjI0NzVWLTEwLjk5NjRILTM5Ljg3MTIiIHN0cm9rZT0iIzBDRTJGMiIgc3Ryb2tlLXdpZHRoPSIwLjY1NzA3MyIvPgo8cGF0aCBvcGFjaXR5PSIwLjQ1IiBkPSJNMTEzOS44OCA0MzYuNjE0SDEwMzMuNjVDNTQ2LjE1NyA0MzYuNjE0IDg1OS4zNTIgLTE5LjEzMjMgMzcxLjg1NCAtMTkuMTMyM1YtMTguODgxNkgtMzIuNzY4IiBzdHJva2U9IiMwQ0UyRjIiIHN0cm9rZS13aWR0aD0iMC42NTcwNzMiLz4KPHBhdGggb3BhY2l0eT0iMC40IiBkPSJNMTE0Ni4zNCA0MjguNzI5SDEwNDAuMjlDNTUzLjU5NSA0MjguNzI5IDg2Ni4yNzIgLTI3LjAxNzMgMzc5LjU4IC0yNy4wMTczVi0yNi43NjY2SC0yNC4zNzM1IiBzdHJva2U9IiMwQ0UyRjIiIHN0cm9rZS13aWR0aD0iMC42NTcwNzMiLz4KPHBhdGggb3BhY2l0eT0iMC4zNSIgZD0iTTExNTQuNzQgNDIwLjg0NEgxMDQ4LjUxQzU2MS4wMDggNDIwLjg0NCA4NzQuMjAzIC0zNC45MDIxIDM4Ni43MDYgLTM0LjkwMjFWLTM0LjY1MTRILTE3LjkxNjMiIHN0cm9rZT0iIzBDRTJGMiIgc3Ryb2tlLXdpZHRoPSIwLjY1NzA3MyIvPgo8cGF0aCBvcGFjaXR5PSIwLjMiIGQ9Ik0xMTYxLjE5IDQxMi45NTlIMTA1NS4wOEM1NjguMTIgNDEyLjk1OSA4ODAuOTcgLTQyLjc4NyAzOTQuMDA5IC00Mi43ODdWLTQyLjUzNjNILTEwLjE2NzIiIHN0cm9rZT0iIzBDRTJGMiIgc3Ryb2tlLXdpZHRoPSIwLjY1NzA3MyIvPgo8cGF0aCBvcGFjaXR5PSIwLjI1IiBkPSJNMTE2OC45NCA0MDUuMDc0SDEwNjIuNzFDNTc1LjIxNSA0MDUuMDc0IDg4OC40MSAtNTAuNjcxOSA0MDAuOTEyIC01MC42NzE5Vi01MC40MjEySC0zLjcwOTk2IiBzdHJva2U9IiMwQ0UyRjIiIHN0cm9rZS13aWR0aD0iMC42NTcwNzMiLz4KPHBhdGggb3BhY2l0eT0iMC4yIiBkPSJNMTE3NS40IDM5Ny4xODlIMTA2OS4zNUM1ODIuNjUzIDM5Ny4xODkgODk1LjMzIC01OS4zNDUyIDQwOC42MzggLTU5LjM0NTJWLTU5LjA5NDFINC42ODQ2OSIgc3Ryb2tlPSIjMENFMkYyIiBzdHJva2Utd2lkdGg9IjAuNjU3MDczIi8+CjxwYXRoIG9wYWNpdHk9IjAuMTUiIGQ9Ik0xMTgzLjc5IDM4OC41MTZIMTA3Ny41NkM1OTAuMDY2IDM4OC41MTYgOTAzLjI2MSAtNjcuMjMwMSA0MTUuNzY0IC02Ny4yMzAxVi02Ni45Nzk0SDExLjE0MiIgc3Ryb2tlPSIjMENFMkYyIiBzdHJva2Utd2lkdGg9IjAuNjU3MDczIi8+CjxwYXRoIG9wYWNpdHk9IjAuMSIgZD0iTTExOTAuMjUgMzgwLjYzMUgxMDg0LjE0QzU5Ny4xNzggMzgwLjYzMSA5MTAuMDI4IC03NS4xMTUxIDQyMy4wNjcgLTc1LjExNTFWLTc0Ljg2NDRIMTguODkwNiIgc3Ryb2tlPSIjMENFMkYyIiBzdHJva2Utd2lkdGg9IjAuNjU3MDczIi8+CjxwYXRoIG9wYWNpdHk9IjAuMDUiIGQ9Ik0xMTk4IDM3Mi43NDZIMTA5MS44M0M2MDQuNiAzNzIuNzQ2IDkxNy42MjIgLTgzIDQzMC4zOTMgLTgzVi04Mi43NDkzSDI1Ljk5MzgiIHN0cm9rZT0iIzBDRTJGMiIgc3Ryb2tlLXdpZHRoPSIwLjY1NzA3MyIvPgo8L2c+CjwvZz4KPGRlZnM+CjxjbGlwUGF0aCBpZD0iY2xpcDBfMzRfMzQ2Ij4KPHJlY3Qgd2lkdGg9IjEzMzMiIGhlaWdodD0iMjAwIiBmaWxsPSJ3aGl0ZSIvPgo8L2NsaXBQYXRoPgo8L2RlZnM+Cjwvc3ZnPgo=";

      if (this.fileName === 'rancher-logo.svg') {
          return logo;
      }

      if (this.fileName === 'banner.svg') {
          return banner;
      }

      if (this.fileName === 'login-landscape.svg') {
        if (this.theme === 'dark' && this.uiLoginBackgroundDark) {
          return this.uiLoginBackgroundDark;
        }

        if (this.uiLoginBackgroundLight) {
          return this.uiLoginBackgroundLight;
        }
      }

      if (!this.brand) {
        return this.defaultPathToBrandedImage;
      } else {
        if (this.theme === 'dark' || this.dark) {
          try {
            return require(`~shell/assets/brand/${ this.brand }/dark/${ this.fileName }`);
          } catch {}
        }
        try {
          return require(`~shell/assets/brand/${ this.brand }/${ this.fileName }`);
        } catch {}

        return this.defaultPathToBrandedImage;
      }
    },
  }
};
</script>
<template>
  <img
    v-bind="$attrs"
    :src="pathToBrandedImage"
  >
</template>
